require 'ripple'

module Ripple
  module Statistics
  end
end

# Include all of the support files.
FileList[File.expand_path(File.join('..','ripple-statistics','*.rb'),__FILE__)].each{|f| require f}
