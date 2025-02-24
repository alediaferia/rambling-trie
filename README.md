# Rambling Trie

[![Gem Version][badge_fury_badge]][badge_fury_link] [![Dependency Status][gemnasium_badge]][gemnasium_link] [![Build Status][travis_ci_badge]][travis_ci_link] [![Code Climate][code_climate_badge]][code_climage_link] [![Coverage Status][coveralls_badge]][coveralls_link] [![Documentation Status][inch_ci_badge]][inch_ci_link]

The Rambling Trie is a custom implementation of the Trie data structure with Ruby, which includes compression abilities and is designed to be very fast to traverse.

## Installing the Rambling Trie

### Requirements

You will need:

* Ruby 1.9.3 or up
* RubyGems

See [RVM][rvm] or [rbenv][rbenv] for more information on how to manage Ruby versions.

### Installation

You can either install it manually with:

``` bash
gem install rambling-trie
```

Or, include it in your `Gemfile` and bundle it:

``` ruby
gem 'rambling-trie'
```

## How to use the Rambling Trie

To create the trie, initialize it like this:

``` ruby
trie = Rambling::Trie.create
```

You can also provide a block and the created instance will be yielded for you to perform any operation on it:

``` ruby
Rambling::Trie.create do |trie|
  trie << 'word'
end
```

Additionally, you can provide the path to a file that contains all the words to be added to the trie, and it will read the file and create the complete structure for you, like this:

``` ruby
trie = Rambling::Trie.create '/path/to/file'
```

By default, a plain text file with the following format will be expected:

``` text
some
words
to
populate
the
trie
```

If you want to use a custom file format, you will need to provide a custom file reader that defines the `each_word` method that yields each word contained in the file. Look at the `Rambling::Trie::PlainTextReader` class for an example.

To add new words to the trie, use `add` or `<<`:

``` ruby
trie.add 'word'
trie << 'word'
```

And to find out if a word already exists in the trie, use `word?` or `include?`:

``` ruby
trie.word? 'word'
trie.include? 'word'
```

If you wish to find if part of a word exists in the trie instance, you should call `partial_word?`:

``` ruby
trie.partial_word? 'partial_word'
trie.match? 'partial_word'
```

### Compression

By default, the Rambling Trie works as a Standard Trie.
Starting from version 0.1.0, you can obtain a Compressed Trie from the Standard one, by using the compression feature.
Just call the `compress!` method on the trie instance:

``` ruby
trie.compress!
```

This will reduce the amount of Trie nodes by eliminating the redundant ones, which are the only-child non-terminal nodes.

__Note that the `compress!` method acts over the trie instance it belongs to.__
__Also, adding words after compression is not supported.__

You can find out if a trie instance is compressed by calling the `compressed?` method:

``` ruby
trie.compressed?
```

### Enumeration

Starting from version 0.4.2, you can use any `Enumerable` method over a trie instance, and it will iterate over each word contained in the trie. You can now do things like:

``` ruby
trie.each do |word|
  puts word
end

trie.any? { |word| word.include? 'x' }
# etc.
```

## Further Documentation

You can find further API documentation on the autogenerated [rambling-trie gem RubyDoc.info page][rubydoc] or if you want edge documentation, you can go the [GitHub project RubyDoc.info page][rubydoc_github].

## Compatible Ruby and Rails versions

The Rambling Trie has been tested with the following Ruby versions:

* 2.3.x
* 2.2.x
* 2.1.x
* 2.0.0
* 1.9.3

Ruby 1.8.7 and 1.9.2 are not supported.

## Contributing to Rambling Trie

If you want to contribute to this project, you will need RSpec to run the tests.
Also, be sure to add tests for any feature you may develop or bug you may fix.

## License and copyright

Copyright (c) 2012-2015 Edgar Gonzalez

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[badge_fury_badge]: https://badge.fury.io/rb/rambling-trie.svg
[badge_fury_link]: https://badge.fury.io/rb/rambling-trie
[code_climage_link]: https://codeclimate.com/github/gonzedge/rambling-trie
[code_climate_badge]: https://codeclimate.com/github/gonzedge/rambling-trie/badges/gpa.svg
[coveralls_badge]: https://img.shields.io/coveralls/gonzedge/rambling-trie.svg
[coveralls_link]: https://coveralls.io/r/gonzedge/rambling-trie
[gemnasium_badge]: https://gemnasium.com/gonzedge/rambling-trie.svg
[gemnasium_link]: https://gemnasium.com/gonzedge/rambling-trie
[inch_ci_badge]: https://inch-ci.org/github/gonzedge/rambling-trie.svg?branch=master
[inch_ci_link]: https://inch-ci.org/github/gonzedge/rambling-trie
[rbenv]: https://github.com/sstephenson/rbenv
[rubydoc]: http://rubydoc.info/gems/rambling-trie
[rubydoc_github]: http://rubydoc.info/github/gonzedge/rambling-trie
[rvm]: https://rvm.io
[travis_ci_badge]: https://travis-ci.org/gonzedge/rambling-trie.svg
[travis_ci_link]: https://travis-ci.org/gonzedge/rambling-trie
