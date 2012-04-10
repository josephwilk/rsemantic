# Rsemantic

[![Build Status](https://secure.travis-ci.org/josephwilk/rsemantic.png?branch=master)](http://travis-ci.org/josephwilk/rsemantic)

A Ruby document vector search with flexible matrix transforms. Current supported transforms: 

* Latent semantic analysis
* Term frequency - inverse document frequency

Documentation: http://github.com/josephwilk/rsemantic/wikis/home

## Requirements:

* GSL - http://www.gnu.org/software/gsl
* stemmer - http://rubyforge.org/projects/stemmer/

## INSTALL:

Note 'brew install GSL' installs 1.15 which is not supported yet by the gsl gem. So you have to switch your GSL version to 1.14.
See here for details on how to do that with homebrew: http://bretthard.in/2012/03/getting-related_posts-lsi-and-gsl-to-work-in-jekyll/

<pre><code>git clone git://github.com/josephwilk/rsemantic.git
brew install GSL

bundle install
</code></pre>

## Contributors
* @josephwilk
* @dominikhonnef

## LICENSE

(The MIT License)

Copyright (c) 2008-2012 Joseph Wilk

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


