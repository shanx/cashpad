import unittest
import doctest

from zope.fanstatic.testing import ZopeFanstaticBrowserLayer
from zope.app.wsgi.testlayer import BrowserLayer, http

import cashpad.tests

browser_layer = ZopeFanstaticBrowserLayer(cashpad.tests)

# NOTE: This is copied from grok core functional tests
# Since adding headers is _not_ implemented correctly
# using keyword arguments.
def http_call(method, path, data=None, headers=None, handle_errors=False):
    """Function to help make RESTful calls.

    method - HTTP method to use
    path - testbrowser style path
    data - (body) data to submit
    kw - any request parameters
    """

    if path.startswith('http://localhost'):
        path = path[len('http://localhost'):]
    request_string = '%s %s HTTP/1.1\n' % (method, path)
    if headers is not None:
        for key, value in headers.items():
            request_string += '%s: %s\n' % (key, value)
    if data is not None:
        request_string += '\r\n'
        request_string += data
    return http(request_string, handle_errors)


def test_suite():
    suite = unittest.TestSuite()

    app_test = doctest.DocFileSuite('../../../../docs/api/resources/user.rst', '../../../../docs/api/resources/order.rst', 'browser.txt',
        optionflags = (
            doctest.ELLIPSIS +
            doctest.NORMALIZE_WHITESPACE +
            doctest.REPORT_NDIFF),
        globs={'getRootFolder': browser_layer.getRootFolder})
    app_test.layer = browser_layer

    suite.addTest(app_test)
    return suite
