.. _index:

====================
Rest API for CashPad
====================

Introduction
============

The CashPad iPad and iPhone apps will register their orders with a central backend. For version 1 of the backend this will be a simple flow:

* CashPad will register orders locally within the app
* At some point in time a CashPad user wants to push the new orders to the backend
* The user presses the sync button
* All orders that have not been transferred before will be pushed to the server

The apps have a responsibility to flag already pushed orders locally within the sqlite datastore.

Contents
--------

.. toctree::
   :maxdepth: 3
   
   api/index