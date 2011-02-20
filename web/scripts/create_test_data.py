import random
import datetime
import dateutil
import dateutil.relativedelta
import dateutil.rrule

# Script to create test data for cashpad
import transaction
# import root

from cashpad.models import App, UserContainer, User, Order, Item

NR_ORDERS_MIN = 14
NR_ORDERS_MAX = 25

NR_ITEMS_MIN = 1
NR_ITEMS_MAX = 5

NR_UNITS_MIN = 1
NR_UNITS_MAX = 3


USER_SET = [
    ('e50029632d79229ad10efd903377c7893bc40199', {'name': 'Test Iphone'}),
    ('1a4d67',{'name': 'iPhone 1'}),
    ('9aa71d',{'name': 'iPhone 2'}),
    ('e883f1',{'name': 'iPhone 3'}),
]

EMPTY_ITEM_SET = [
    {
        'product_id': 1,
        'product_name': 'Cola',
        'amount': 0,
        'unit_price': 2.0,
    },
    {
        'product_id': 2,
        'product_name': 'Bier',
        'amount': 0,
        'unit_price': 2.5,
    },
    {
        'product_id': 3,
        'product_name': 'Frites',
        'amount': 0,
        'unit_price': 1.5,
    },
    {
        'product_id': 4,
        'product_name': 'Kroket',
        'amount': 0,
        'unit_price': 1.0,
    }
]

# If the app root is present, remove it
try:
    del root['app']
    transaction.commit()
except KeyError:
    pass

app = root['app'] = App()

from zope.site.hooks import setSite
setSite(app)
# user_container = app['user'] = UserContainer()

today = datetime.date.today()
last_week = today + dateutil.relativedelta.relativedelta(weeks=-1)
week = [day.date() for day in dateutil.rrule.rrule(
        dateutil.rrule.DAILY, count=7, dtstart=last_week)]

for (user_key, user_data) in USER_SET:
    app['user'].add(User(user_data['name'], user_key))
    
    # For each day from one week ago to yesterday
    for day in week:
        # Generate a random number of orders
        for order_nr in range(0, random.randint(NR_ORDERS_MIN, NR_ORDERS_MAX)):
            # Generate an order with a random number of items
            item_list = []
            for item_nr in range(0, random.randint(NR_ITEMS_MIN, NR_ITEMS_MAX)):
                # Get a random product from the set
                new_item = Item()
                product = random.choice(EMPTY_ITEM_SET)
                new_item.product_id = product['product_id']
                new_item.product_name = product['product_name']
                new_item.amount = random.randint(NR_UNITS_MIN, NR_UNITS_MAX)
                new_item.unit_price = product['unit_price']

                item_list.append(new_item)
            
            new_order = Order()
            # FIXME: Last minute stress :)
            new_order.created_on = datetime.datetime(day.year, day.month, day.day, 1, 1, 1)
            new_order.total_price = sum([i.unit_price * i.amount for i in item_list])
            new_order.item_list = item_list
            
            app['user'][user_key]['order'].add(new_order)

transaction.commit()