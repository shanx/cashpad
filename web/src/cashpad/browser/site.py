import grok
from cashpad.app import App

grok.template_dir('templates')
class Index(grok.View):
    grok.context(App)