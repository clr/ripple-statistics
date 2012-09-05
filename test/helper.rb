$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'test/unit'
require 'minitest/autorun'

require 'ripple'
require 'ripple-statistics'

ENV['RACK_ENV']   = 'test'
ENV['RIPPLE']     = File.expand_path(File.join('..','fixtures','ripple.yml'),__FILE__)

# connect to a local Riak test node
begin
  Ripple.load_configuration ENV['RIPPLE'], ['test']
  riak_config = Hash[YAML.load_file(ENV['RIPPLE'])['test'].map{|k,v| [k.to_sym, v]}]
  client = Riak::Client.new(:nodes => [riak_config])
  bucket = client.bucket("#{riak_config[:namespace].to_s}test") 
  object = bucket.get_or_new("test") 
rescue RuntimeError
  raise RuntimeError, "Could not connect to the Riak test node. Are you sure it is running on port #{riak_config[:http_port]}?"
end

# clean up from prior tests
Riak.disable_list_keys_warnings = true
Ripple::Statistics::Average.destroy_all
Ripple::Statistics::Count.destroy_all
Ripple::Statistics::Sum.destroy_all
