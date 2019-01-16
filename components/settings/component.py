from batou.component import Component


class Settings(Component):

    subdomain = '.dev'

    def configure(self):
        self.provide('settings', self)
