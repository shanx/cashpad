from zope import interface, schema

class IUser(interface.Interface):
    name = schema.ASCIILine(title=u'Name of the user', required=True)
    device_id = schema.ASCIILine(title=u'Device ID', required=True)


class IItem(interface.Interface):
    product_id = schema.Int(title=u'ID of the product', required=True)
    product_name = schema.ASCIILine(title=u'Name of the product', required=True)
    amount = schema.Int(title=u'Amount of products order', required=True)
    unit_price = schema.Float(title=u'Price of a single unit of the order', required=True)


class IOrder(interface.Interface):
    created_on = schema.Datetime(title=u'Creation datetime of order', required=True)
    total_price = schema.Float(title=u'Total price of the order', required=True)
    item_list = schema.List(title=u'List of items', value_type=schema.Object(IItem))
