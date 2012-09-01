require 'helper'
require 'ripple'

class DataDocument
  include Ripple::Document
  include Ripple::Statistics::Average

  property :value, Integer, :presence => true
  property_average :value
end

class TestJsonDocument < MiniTest::Spec
  def setup
    11..17.each do |value|
      DataDocument.create(:value => value.to_i)
    end
  end

  def test_average_of_data_document_values
    assert_equal 14, DataDocument.value_average
  end
end
