require 'helper'

class TestSumRippleDocument
  include Ripple::Document
  include Ripple::Statistics

  property :value, Float, :presence => true
  property_sum :value
end

class TestSumDocument < Test::Unit::TestCase
  def test_sum_of_ripple_document_values
    (11..17).each do |value|
      TestSumRippleDocument.create(:value => (value.to_f + 0.05))
    end
    assert_equal 98.35, TestSumRippleDocument.value_sum
  end
end
