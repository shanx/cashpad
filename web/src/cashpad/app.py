import simplejson
import datetime

import grok
from zope.location.location import located
from zope.formlib.form import applyData
from zope.schema.fieldproperty import FieldProperty

from cashpad.interfaces import IOrder, IItem

class APILayer(grok.IRESTLayer):
    grok.restskin('api')

class Users(grok.Container):
    pass

class App(grok.Application, grok.Container):
    def __init__(self):
        super(App, self).__init__()
        self['user'] = Users()

# FIXME: Traverser doesn't work
# class AppTraverser(grok.Traverser):
#     grok.context(App)
#
#     def traverse(self, name):
#         if name == 'api':
#             grok.util.applySkin(self.request, APILayer, grok.IRESTSkinType)
#             return located(self.context, self.context.__parent__, 'boeetlkjalkaj')

class Orders(grok.Container):
    pass

class User(grok.Container, grok.Model):
    def __init__(self):
        super(User, self).__init__()
        self['order'] = Orders()

# XXX PUT requests in grok don't work like you would expect them to?
class UsersTraverser(grok.Traverser):
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
            # FIXME: user should not be a hardcoded string like this
            return located(self.context, self.context.__parent__, self.context.__name__)


class UsersREST(grok.REST):
    grok.context(Users)
    grok.layer(APILayer)

    def PUT(self):
        # XXX We/grok should set the location here.
        return ''

class Item(grok.Model):
    grok.implements(IItem)
    product_id = FieldProperty(IItem['product_id'])
    product_name = FieldProperty(IItem['product_name'])
    amount = FieldProperty(IItem['amount'])
    unit_price = FieldProperty(IItem['unit_price'])


class Order(grok.Model):
    grok.implements(IOrder)
    created_on = FieldProperty(IOrder['created_on'])
    total_price = FieldProperty(IOrder['total_price'])
    item_list = FieldProperty(IOrder['item_list'])

class OrdersREST(grok.REST):
    grok.context(Orders)
    grok.layer(APILayer)

    def POST(self):
        order_data = simplejson.loads(self.body)
        # Change the created_on timestamp to a datetime
        order_data['created_on'] = datetime.datetime.fromtimestamp(order_data['created_on'])

        item_list = []
        for item_data in order_data['item_list']:
            item = Item()
            applyData(item, grok.Fields(IItem), item_data)
            item_list.append(item)

        order_data['item_list'] = item_list

        key = len(self.context) and max(self.context) + 1 or 1
        order = Order()
        applyData(order, grok.Fields(IOrder), order_data)
        self.context[str(key)] = order
        self.response.setHeader('Location', self.url(order))
        self.response.setStatus('201')
        return ''

