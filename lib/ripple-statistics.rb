require 'ripple'

module Ripple
  module Statistics
  end
end

Ripple.config[:client_name] = ENV['RIPPLE_CLIENT_NAME'] if ENV['RIPPLE_CLIENT_NAME']

# Include all of the support files.
Dir[File.expand_path(File.join('..','ripple-statistics','*.rb'),__FILE__)].each{|f| require f}
