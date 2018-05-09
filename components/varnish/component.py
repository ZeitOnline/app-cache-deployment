from batou.component import Component, Attribute
from batou.lib.file import Directory, File

class Varnish(Component):
    def configure(self):
        self += File("default.vcl", source="default.vcl.tpl", is_template="true")

