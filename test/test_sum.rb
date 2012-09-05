require 'helper'

class TestSum < Test::Unit::TestCase
  def test_updating_simple_values
    statistic = Ripple::Statistics::Sum.new(:key => 'test_sum')
    statistic.key = 'test'

    statistic.update_with(10)
    assert_equal 10.0, statistic.sum

    statistic.update_with(5)
    assert_equal 15.0, statistic.sum

    statistic.update_with(12.175)
    assert_equal 27.175, statistic.sum
  end

  def test_conflict_resolution_of_siblings
    key = 'average_siblings'
    siblings = []
    siblings[0] = Ripple::Statistics::Sum.new(:key => key)
    siblings[0].key = key
    siblings[0].update_with 10

    3.times do
      siblings << Ripple::Statistics::Sum.find(key)
    end

    siblings[1].update_with 10
    statistic = Ripple::Statistics::Sum.find(key)
    assert_equal 20.0, statistic.sum

    siblings[2].update_with 7
    statistic = Ripple::Statistics::Sum.find(key)
    assert_equal 27.0, statistic.sum

    siblings[3].update_with 13
    statistic = Ripple::Statistics::Sum.find(key)
    assert_equal 40.0, statistic.sum

    siblings[0].update_with 19
    statistic = Ripple::Statistics::Sum.find(key)
    assert_equal 59.0, statistic.sum

    siblings[0].update_with 13.148
    statistic = Ripple::Statistics::Sum.find(key)
    assert_equal 72.148, statistic.sum
  end
end
