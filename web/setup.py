from setuptools import setup, find_packages

version = '0.0'

setup(name='cashpad',
      version=version,
      description="",
      long_description="""\
""",
      # Get strings from http://www.python.org/pypi?%3Aaction=list_classifiers
      classifiers=[],
      keywords="",
      author="",
      author_email="",
      url="",
      license="",
      package_dir={'': 'src'},
      packages=find_packages('src'),
      include_package_data=True,
      zip_safe=False,
      install_requires=['setuptools',
                        'grok',
                        'grokui.admin',
                        'fanstatic',
                        'zope.fanstatic',
                        'grokcore.startup',
                        'js.jquery',
                        'js.jquery_tablesorter',
                        'python-dateutil',
                        ],
      extras_require={'test': ['gocept.selenium[grok] >= 0.9']},
      entry_points={
          'fanstatic.libraries': [
              'cashpad = cashpad.browser.resource:library',
          ]
      })
