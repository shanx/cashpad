# The tests in test_cashpad.py are picked up by zope.testrunner.

# When decorating a unittest.TestCase or doctest with a layer, the layer is
# used to group tests and execute setup and teardown of the grok environment
# for the test to run in.

import unittest
import doctest

from zope.fanstatic.testing import ZopeFanstaticBrowserLayer

import cashpad.tests

browser_layer = ZopeFanstaticBrowserLayer(cashpad.tests)

def test_suite():
    suite = unittest.TestSuite()

    app_test = doctest.DocFileSuite('app.txt', # Add more doctest files here.
        optionflags = (
            doctest.ELLIPSIS +
            doctest.NORMALIZE_WHITESPACE +
            doctest.REPORT_NDIFF),
        globs={'getRootFolder': browser_layer.getRootFolder})
    app_test.layer = browser_layer

    suite.addTest(app_test)
    return suite
