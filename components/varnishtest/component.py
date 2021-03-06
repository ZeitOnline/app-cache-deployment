from batou import UpdateNeeded
from batou.component import Component
from batou.lib.file import Directory, File
from glob import glob
import batou
import batou.lib.file
import jinja2
import os


BACKENDS = {
    'haproxy',
}


class Docker(Component):

    image = 'varnish_test_app_cache'

    def configure(self):
        self += File("Dockerfile")
        self += File(".dockerignore")

    def verify(self):
        self.parent.assert_no_subcomponent_changes()
        out, _ = self.cmd('docker image ls %s' % self.image)
        if self.image not in out:
            raise UpdateNeeded()

    def update(self):
        self.cmd("docker build -t %s ." % self.image)


class Varnishtest(Component):
    def configure(self):
        self.vcldir = self.require_one('varnish_dir', self.host)
        self.render_varnishtest_templates()
        self += File('conftest.py')
        self += File("test_varnish_config.py")
        self += File("run.sh", mode=0o755)

        self += File('local.vcl')
        self += File('local-varnish.sh', mode=0o755)
        self += File('varnish.sh', mode=0o755)

        self += Docker()

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
                tpl = env.get_template('preprocess.vtc')
                tpl = tpl.render(vtc=path)
                self += File(path, content=tpl)
        # Remove deleted/renamed files.
        for vtc in glob(self.workdir + '/tests/*.vtc'):
            if not os.path.isfile(
                    self.defdir + '/tests/' + os.path.basename(vtc)):
                self += DeleteFile(vtc)


class DummyVarnishtest(Component):
    """ Only needed for configuration of prod environments,
        where testing isn't needed."""
    def configure(self):
        self.vcldir = self.require_one('varnish_dir', self.host)


class DeleteFile(Component):
    """XXX batou.lib.File really should support `ensure=absent`."""

    namevar = 'path'

    def configure(self):
        self.path = self.map(self.path)

    def verify(self):
        if os.path.isfile(self.path):
            raise batou.UpdateNeeded()

    def update(self):
        batou.lib.file.ensure_path_nonexistent(self.path)
