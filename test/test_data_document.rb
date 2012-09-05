require 'helper'

class DataDocument
  include Ripple::Document
  include Ripple::Statistics

  property :value, Float, :presence => true
  property_average :value
  property_sum :value
  property_count :value
end

class TestJsonDocument < MiniTest::Spec
  def setup
    (11..17).each do |value|
      DataDocument.create(:value => value.to_i)
    end
  end

  def test_average_of_data_document_values
    assert_equal 14, DataDocument.value_average
  end
end
