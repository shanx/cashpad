import grok
from zope.schema.fieldproperty import FieldProperty

from cashpad.interfaces import IOrder, IItem

class UserContainer(grok.Container):
    pass

class App(grok.Application, grok.Container):
    def __init__(self):
        super(App, self).__init__()
        self['user'] = UserContainer()

class OrderContainer(grok.Container):
    def add(self, order):
        # FIXME: this is not very elegant
        key = len(self) and max([int(c) for c in self]) + 1 or 1

        self[str(key)] = order


class User(grok.Container, grok.Model):
    def __init__(self):
        super(User, self).__init__()
        self['order'] = OrderContainer()

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
    
