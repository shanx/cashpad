import unittest
import doctest

from zope.fanstatic.testing import ZopeFanstaticBrowserLayer

import cashpad.tests

browser_layer = ZopeFanstaticBrowserLayer(cashpad.tests)

def test_suite():
    suite = unittest.TestSuite()

    app_test = doctest.DocFileSuite('api.txt', 'browser.txt',
        optionflags = (
            doctest.ELLIPSIS +
            doctest.NORMALIZE_WHITESPACE +
            doctest.REPORT_NDIFF),
        globs={'getRootFolder': browser_layer.getRootFolder})
    app_test.layer = browser_layer

    suite.addTest(app_test)
    return suite
