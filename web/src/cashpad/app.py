import grok
from zope.location.location import located

class APILayer(grok.IRESTLayer):
    grok.restskin('api')

class Users(grok.Container):
    pass

class App(grok.Application, grok.Container):
    def __init__(self):
        super(App, self).__init__()
        self['user'] = Users()

class AppTraverser(grok.Traverser):
    grok.context(App)

    def traverse(self, name):
        if name == 'api':
            grok.util.applySkin(self.request, APILayer, grok.IRESTSkinType)
            return located(self.context, name)

class Orders(grok.Container):
    pass

class User(grok.Container, grok.Model):
    def __init__(self):
        super(User, self).__init__()
        self['order'] = Orders()

# XXX PUT requests in grok don't work like you would expect them to?
class UserTraverser(grok.Traverser):
    grok.context(Users)
    grok.layer(APILayer)

    def traverse(self, name):
        if self.request.method == 'PUT':
            response = self.request.response
            user = self.context.get(name)
            if user is None:
                user = self.context[name] = User()
                response.setStatus('201')
            else:
                response.setStatus('204')
            return located(self.context, name)

class UserREST(grok.REST):
    grok.context(Users)
    grok.layer(APILayer)

    def PUT(self):
        # XXX We/grok should set the location here.
        return ''

class OrderREST(grok.REST):
    grok.context(Orders)
    grok.layer(APILayer)

    def POST(self):
        return "POST request, add something to container"
