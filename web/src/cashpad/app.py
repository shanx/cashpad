import grok

from cashpad import resource

class Cashpad(grok.Application, grok.Container):
    pass

class Index(grok.View):
    def update(self):
        resource.style.need()
