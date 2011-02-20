import grok
from cashpad.app import App

grok.templatedir('templates')
class Index(grok.View):
    grok.context(App)

    def update(self):
        users = self.users = self.context['user']
        orders = self.orders = []
        for user in users.values():
            orders.extend(user['order'].values())
