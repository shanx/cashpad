import unittest

from cashpad.app import Orders, Order

class OrderTests(unittest.TestCase):
    def test_add_order_to_orders_container(self):
        container = Orders()
        order = Order()
        
        # To start the container should be empty
        self.assertTrue(len(container) == 0, 'Container should be empty')
        
        # Adding first order should give it key 1
        container.add(order)
        self.assertTrue('1' in container)
        
        # Adding second order should give it key 2
        container.add(order)
        self.assertTrue('2' in container and '1' in container)
