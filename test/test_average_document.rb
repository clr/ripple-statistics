require 'helper'

class TestAverageRippleDocument
  include Ripple::Document
  include Ripple::Statistics

  property :value, Integer, :presence => true
  property_average :value
end

class TestAverageDocument < Test::Unit::TestCase
  def test_average_of_ripple_document_values
    (11..17).each do |value|
      TestAverageRippleDocument.create(:value => value.to_i)
    end
    assert_equal 14, TestAverageRippleDocument.value_average
  end
end
