import grok
from cashpad.app import App

grok.templatedir('templates')
class Index(grok.View):
    grok.context(App)

    def update(self):
        users = self.context['user']
        self.orders = []
        for user in users.values():
            self.orders.extend(user['order'])
