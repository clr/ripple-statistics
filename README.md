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


## Known Issues

These stats are currently additive only!  They do not yet take into
account deleting an object.

Map/Reduce will be necessary to seed these values for a running system,
since these values are updated on a rolling basis only.


## Usage

Include the gem in your Gemfile.  Then include the Ripple::Statistics module in your document class:

    class SomeDocument
      include Ripple::Document
      include Ripple::Statistics
      property :message,    String
      property :some_value, Float
  
      # now track some stats
      property_average :some_value, :default => 0.0
      property_sum     :some_value, :default => 0.0
      property_count   :some_value, :default => 0
    end

You now have access to the following methods:

    SomeDocument.some_value_average
    SomeDocument.some_value_sum
    SomeDocument.some_value_count

## Running the Tests

Adjust the 'test/fixtures/ripple.yml' to point to a test riak database.

    bundle exec rake

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
