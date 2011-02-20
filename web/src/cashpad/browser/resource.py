from fanstatic import Library, Resource, GroupResource

import js.jquery
import js.jquery_tablesorter

library = Library('cashpad', 'static')

style_css = Resource(library, 'css/style.css')

def ltie8renderer(url):
    return '''<!--[if lt IE 8]><link rel="stylesheet" type="text/css"
        href="%s" media="all" /><![endif]-->''' % url

favicon = Resource(library, 'images/favicon.ico')

css_ie = Resource(library, 'css/ie.css', renderer=ltie8renderer)

style = GroupResource([style_css, css_ie])


visualize_css = Resource(library, 'css/visualize.css')

jquery_visualize_js = Resource(library, 'js/jquery.visualize.js')

jquery_visualize_tooltip_js = Resource(library, 'js/jquery.visualize.tooltip.js',
    depends=[jquery_visualize_js])

visualize = GroupResource(
    [visualize_css, jquery_visualize_js, jquery_visualize_tooltip_js])

custom_js = Resource(library, 'js/custom.js',
    depends=[js.jquery.jquery, visualize, js.jquery_tablesorter.tablesorter])

