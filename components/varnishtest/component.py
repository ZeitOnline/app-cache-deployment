from batou.component import Component, Attribute
from batou.lib.file import Directory, File


class Docker(Component):
    def configure(self):
        self += File("Dockerfile")

    def verify(self):
        self.assert_no_subcomponent_changes()
    def update(self):
        self.cmd("docker build -t varnish_test_app_cache .")


class Varnishtest(Component):
    def configure(self):
        self += Docker()

