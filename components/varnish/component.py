from batou.component import Component, Attribute, platform
from batou.lib.file import Directory, File

class Varnish(Component):

    subdomain = ".dev"

    def configure(self):
        self += File(
            "default.vcl",
            source="default.vcl",
            is_template="true")

        self += Directory('vcl_includes')

        self += File(
             "vcl_includes/acl.vcl",
            source="vcl_includes/acl.vcl",
            is_template="true")
        self += File(
            "vcl_includes/backends.vcl",
            source="vcl_includes/backends.vcl",
            is_template="true")
        self += File(
            "vcl_includes/backend_response.vcl",
            source="vcl_includes/backend_response.vcl",
            is_template="true")
        self += File(
            "vcl_includes/backend_fetch.vcl",
            source="vcl_includes/backend_fetch.vcl",
            is_template="true")
        self += File(
            "vcl_includes/deliver.vcl",
            source="vcl_includes/deliver.vcl",
            is_template="true")
        self += File(
            "vcl_includes/init.vcl",
            source="vcl_includes/init.vcl",
            is_template="true")
        self += File(
            "vcl_includes/main.vcl",
            source="vcl_includes/main.vcl",
            is_template="true")
        self += File(
            "vcl_includes/recv.vcl",
            source="vcl_includes/recv.vcl",
            is_template="true")
        self += File(
            "vcl_includes/synth.vcl",
            source="vcl_includes/synth.vcl",
            is_template="true")
        self += File(
            "vcl_includes/hit_miss_pass.vcl",
            source="vcl_includes/hit_miss_pass.vcl",
            is_template="true")
        self += File(
            "vcl_includes/test.vcl",
            source="vcl_includes/test.vcl",
            is_template="true")

        self.provide('varnish_dir', self.workdir)


@platform('debian', Varnish)
class ReloadVarnish(Component):

    def verify(self):
        self.parent.assert_no_subcomponent_changes()

    def update(self):
        self.cmd('sudo /bin/systemctl reload varnish.service')



