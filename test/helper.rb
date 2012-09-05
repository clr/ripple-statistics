$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'test/unit'
require 'minitest/autorun'

require 'environment'

# clean up from prior tests
Riak.disable_list_keys_warnings = true
Ripple::Statistics::Average.destroy_all
Ripple::Statistics::Count.destroy_all
Ripple::Statistics::Sum.destroy_all
DataDocument.destroy_all
