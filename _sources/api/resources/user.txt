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

The request doesn't have request parameters.

**Response**

``201 Created``
    If a new user was successfully created.

``204 No Content``
    If a currently existing user was updated successfully

**Possible errors**

``400 Bad Request``
    If the request data could not be parsed.