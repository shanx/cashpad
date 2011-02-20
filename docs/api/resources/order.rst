Order
=====

An order is a list of products being paid by a customer using the CashPad app.

**Route**

``POST http://www.ipadkassasysteem.nl/++rest++api/user/{user_id}/order/``
    Create a new order for the selected ``User`` resource.

**Request**

The request can contain the following fields:

* **created_on** (``integer``): Timestamp of the creation datetime of the order in the CashPad app.
* **total_price** (``float``): Total price of the order
* **item_list** (``array``): List of items that are part of the order.
    * **product_id** (``integer``): Unique id identifying the product.
    * **product_name** (``string``): Name of the product.
    * **amount** (``integer``): Amount of products ordered.
    * **unit_price** (``float``): Price of the product per unit.

**Response**

``201 Created``

**Possible errors**

``400 Bad Request``
    If the request data could not be parsed.

Examples
--------

.. testsetup::

    # Let's first create an instance at the top level:
    >>> from cashpad.models import App
    >>> root = getRootFolder()
    >>> app = root['app'] = App()

    >>> import simplejson
    >>> from cashpad.tests.tests import http_call
    >>> from zope.publisher.interfaces import BadRequest

    >>> user = {
    ...     'name': 'mobile user'
    ... }
    >>> user_data = data=simplejson.dumps(user)
    >>> response = http_call('PUT', 'http://localhost/++rest++api/app/user/123', data=user_data,
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})


Sending anything with a Content-Type other than application/json should have grok smash your head to pieces::

    >>> response = http_call('POST', 'http://localhost/++rest++api/app/user/123/order/', data='')
    Traceback (most recent call last):
    ...
    BadRequest: Content is not of type: application/json; charset=utf-8

Pushing no json should return 400 Bad request::

    >>> response = http_call('POST', 'http://localhost/++rest++api/app/user/123/order/', data='', 
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})
    Traceback (most recent call last):
    ...
    BadRequest: Content could not be parsed

Create a new order::

    >>> order = {
    ...     'created_on': 1298133944,
    ...     'total_price': 19.75,
    ...     'item_list': [
    ...         {
    ...             'product_id': 1,
    ...             'product_name': 'cola',
    ...             'amount': 2,
    ...             'unit_price': 2.10,
    ...         },
    ...         {
    ...             'product_id': 2,
    ...             'product_name': 'pizza calzone',
    ...             'amount': 1,
    ...             'unit_price': 15.55,
    ...         }
    ...     ]
    ... } 
    
    >>> response = http_call('POST', 'http://localhost/++rest++api/app/user/123/order/', data=simplejson.dumps(order),
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})
    >>> response.getStatus()
    201

    >>> first_order = response.getHeader('Location')
    >>> print first_order
    http://localhost/++rest++api/app/user/123/order/1

Test if the content actually was inserted in the ZODB::

    >>> app['user']['123']['order']['1'].created_on
    datetime.datetime(2011, 2, 19, 17, 45, 44)

    >>> [i.product_name for i in app['user']['123']['order']['1'].item_list]
    ['cola', 'pizza calzone']

Test repeated insert::

    >>> order = {
    ...     'created_on': 1298133944,
    ...     'total_price': 4.20,
    ...     'item_list': [
    ...         {
    ...             'product_id': 1,
    ...             'product_name': 'cola',
    ...             'amount': 2,
    ...             'unit_price': 2.10,
    ...         }
    ...     ]
    ... } 
    
    >>> response = http_call('POST', 'http://localhost/++rest++api/app/user/123/order/', data=simplejson.dumps(order),
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})
    >>> response.getStatus()
    201

Test int values for fields that would normally expect float and test proper coercion ::

    >>> order = {
    ...     'created_on': 1298133944,
    ...     'total_price': 4,
    ...     'item_list': [
    ...         {
    ...             'product_id': 1,
    ...             'product_name': 'cola',
    ...             'amount': 2,
    ...             'unit_price': 2,
    ...         }
    ...     ]
    ... } 
    
    >>> response = http_call('POST', 'http://localhost/++rest++api/app/user/123/order/', data=simplejson.dumps(order),
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})
    >>> response.getStatus()
    201

    >>> app['user']['123']['order']['3'].total_price
    4.0

    >>> [i.unit_price for i in app['user']['123']['order']['3'].item_list]
    [2.0]
