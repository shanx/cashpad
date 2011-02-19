Order
=====

An order is a list of products being paid by a customer using the CashPad app.

**Route**

``POST http://www.ipadkassasysteem.nl/api/user/{user_id}/order/``
    Create a new order for the selected ``User`` resource.

**Request**

The request can contain the following fields:

* **created_on** (``datetime``): Datetime on which the order was created in the CashPad app.
* **item_list** (``array``): List of items that are part of the order.
    * **product_id** (``integer``): Unique id identifying the product.
    * **product_name** (``string``): Name of the product.
    * **amount** (``integer``): Amount of products ordered.
    * **unit_price** (``decimal``): Price of the product per unit.

**Response**

``201 Created``

**Possible errors**

``400 Bad Request``
    If the request data could not be parsed.