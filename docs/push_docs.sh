#!/bin/bash
cd _build/html

git commit -a -m "Updated documentation"
git push origin gh-pages
