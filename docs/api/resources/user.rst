User
====

.. note::

    Having multiple clients generate global unique id's is of course **quite crazy** but for the first prototype
    these unnecessary levels of abstraction have been left out.

A user is a unique instance of the CashPad application. Clients are responsible for creating their own unique user_id.

**Route**

``PUT http://www.ipadkassasysteem.nl/++rest++api/user/{user_id}``
    Create or update a new User resource that can be addressed by ``user_id``.

.. note::

    Our advice for creating the ``user_id`` locally is to hash the unique device id with a local pre-generated key.


**Request**

The request can contain the following fields:

* **name** (``string``): Name of the device

**Response**

``201 Created``
    If a new user was successfully created.

``204 No Content``
    If a currently existing user was updated successfully

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

Sending anything with a Content-Type other than application/json should have grok smash your head to pieces::

    >>> response = http_call('PUT', 'http://localhost/++rest++api/app/user/123', data='')
    Traceback (most recent call last):
    ...
    BadRequest: Content is not of type: application/json; charset=utf-8

Pushing no json should return 400 Bad request::

    >>> response = http_call('PUT', 'http://localhost/++rest++api/app/user/123/', data='',
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})
    Traceback (most recent call last):
    ...
    BadRequest: Content could not be parsed

Create a user::

    >>> user = {
    ...     'name': 'mobile user'
    ... }
    >>> user_data = simplejson.dumps(user)
    >>> response = http_call('PUT', 'http://localhost/++rest++api/app/user/123', data=user_data,
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})
    >>> response.getStatus()
    201

    >>> print app['user']['123'].name
    mobile user

User already exists, but name should be updated::

    >>> user = {
    ...     'name': 'new mobile user'
    ... }
    >>> user_data = simplejson.dumps(user)
    >>> response = http_call('PUT', 'http://localhost/++rest++api/app/user/123', data=user_data,
    ...                         headers={'Content-Type': 'application/json; charset=utf-8'})
    >>> response.getStatus()
    204

    >>> print app['user']['123'].name
    new mobile user
