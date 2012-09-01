# Ripple::Statistics

The ripple-statistics gem provides simple statistics for Ripple documents.
[riak-ruby](https://github.com/basho/riak-ruby-client) [ripple](https://github.com/seancribbs/ripple)


## Installation

Add this line to your application's Gemfile:

    gem 'ripple-statistics'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ripple-statistics

## Overview


## Usage

Include the gem in your Gemfile.

    Ripple::Statistics

Then include the Ripple::Statistics module in your document class:

    class SomeDocument
      include Ripple::Document
      include Ripple::Statistics
      property :message, String
    end


## Running the Tests

Adjust the 'test/fixtures/ripple.yml' to point to a test riak database.

    bundle exec rake

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
