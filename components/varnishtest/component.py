import jinja2
import batou
import os
from batou.component import Component, Attribute
from batou.lib.file import SyncDirectory, Directory, File


BACKENDS = {
    'academics',
    'agatho',
    'brandeins',
    'default',
    'newsolr',
    'post',
    'spektrum',
    'zett'
}


class Docker(Component):
    def configure(self):
        vcldir = self.require_one('varnish_dir')
        self += SyncDirectory('config', source=vcldir)
        self += File("Dockerfile")

    def verify(self):
        self.assert_no_subcomponent_changes()

    def update(self):
        self.cmd("docker build -t varnish_test_app_cache .")


class Varnishtest(Component):
    def configure(self):
        self += Docker()
        self.render_varnishtest_templates()
        self += File('conftest.py')
        self += File("test_varnish_config.py")

    def render_varnishtest_templates(self):
        def get_backends(prepone=[], exclude=[], postpone=[]):
            excludables = prepone + exclude + postpone
            return prepone + list(BACKENDS.difference(excludables)) + postpone

        self += Directory("tests")
        defdir = self.expand('{{component.defdir}}')
        loader = loader = jinja2.FileSystemLoader(defdir)
        env = jinja2.Environment(loader=loader, line_statement_prefix='@')
        env.globals['get_backends'] = get_backends
        preprocess = '{}/preprocess.vtc'.format(defdir)

        for vtc in next(os.walk('{}/tests'.format(defdir)))[2]:
            if vtc.endswith('vtc'):
                path = 'tests/{}'.format(vtc)
                batou.output.annotate(preprocess)
                tpl = env.get_template('preprocess.vtc')
                tpl = tpl.render(vtc=path)
                self += File(path, content=tpl)

    def verify(self):
        self.assert_no_subcomponent_changes()

    def update(self):
        pass
        #self.cmd("docker build -t varnish_test_app_cache .")
