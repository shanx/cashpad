import copy
import simplejson
import datetime

import grok
from zope.location.location import located
from zope.formlib.form import applyData
from zope.publisher.interfaces import BadRequest

from cashpad.interfaces import IOrder, IItem
from cashpad.models import OrderContainer, Order, UserContainer, User, Item

class APILayer(grok.IRESTLayer):
    grok.restskin('api')

# class BaseContainerHandler(grok.REST):
#     grok.baseclass()
#     grok.layer(APILayer)

# FIXME: These should be part of the BaseContainerHandler
def validate_proper_contenttype(request):
    if  request.getHeader('Content-Type', '').lower() != 'application/json; charset=utf-8':
        raise BadRequest('Content is not of type: application/json; charset=utf-8')

def parse_json(body):
    "Return parsed json, otherwise raise BadRequest"
    try:
        parsed_body = simplejson.loads(body)
    except ValueError:
        raise BadRequest('Content could not be parsed')

    return parsed_body

# XXX PUT requests in grok don't work like you would expect them to?
class UserContainerTraverser(grok.Traverser):
    grok.context(UserContainer)
    grok.layer(APILayer)

    def traverse(self, device_id):
        if self.request.method == 'PUT':
            validate_proper_contenttype(self.request)
            # FIXME: This call somehow blocks
            # body = self.request.bodyStream.read()
            # user_data = parse_json(body)

            response = self.request.response
            user = self.context.get(device_id)
            if user is None:
                user = User(name=str(device_id), device_id=str(device_id))
                self.context.add(user)
                response.setStatus('201')
            else:
                user.name = str(device_id)
                response.setStatus('204')

            # FIXME: user should not be a hardcoded string like this
            location = located(self.context, self.context.__parent__, self.context.__name__)
            return location

class UserContainerHandler(grok.REST):
    grok.context(UserContainer)

    def PUT(self):
        # XXX We/grok should set the location here.
        return ''


class OrderContainerHandler(grok.REST):
    grok.context(OrderContainer)

    def coerce_order_data(self, original_order_data):
        order_data = copy.deepcopy(original_order_data)

        # Coerce the created_on timestamp to a datetime
        order_data['created_on'] = datetime.datetime.fromtimestamp(order_data['created_on'])
        # Coerce total_price to float
        order_data['total_price'] = float(order_data['total_price'])

        return order_data

    def coerce_item_data(self, original_item_data):
        item_data = copy.deepcopy(original_item_data)

        # Coerce unit_price to float
        item_data['unit_price'] = float(item_data['unit_price'])

        return item_data

    def POST(self):
        validate_proper_contenttype(self.request)
        order_data = parse_json(self.body)
        order_data = self.coerce_order_data(order_data)

        item_list = []
        for item_data in order_data['item_list']:
            item_data = self.coerce_item_data(item_data)

            item = Item()
            applyData(item, grok.Fields(IItem), item_data)
            item_list.append(item)

        order_data['item_list'] = item_list

        order = Order()
        applyData(order, grok.Fields(IOrder), order_data)

        self.context.add(order)

        self.response.setHeader('Location', self.url(order))
        self.response.setStatus('201')
        return ''

