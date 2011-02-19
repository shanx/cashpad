import grok
from cashpad.app import App

grok.templatedir('templates')
class Index(grok.View):
    grok.context(App)