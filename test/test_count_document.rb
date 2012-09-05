require 'helper'

class TestCountRippleDocument
  include Ripple::Document
  include Ripple::Statistics

  property :value, Integer, :presence => true
  property_count :value
end

class TestCountDocument < Test::Unit::TestCase
  def test_count_of_ripple_document_values
    (11..17).each do |value|
      TestCountRippleDocument.create(:value => value.to_i)
    end
    assert_equal 7, TestCountRippleDocument.value_count
  end
end
