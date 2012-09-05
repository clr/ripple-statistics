class DataDocument
  include Ripple::Document
  include Ripple::Statistics

  property :value, Float,  :presence => true
  property_average :value, :default => 0.0
  property_sum     :value, :default => 0.0
  property_count   :value, :default => 0
end
