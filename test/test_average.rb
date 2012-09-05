require 'helper'

class TestAverage < Test::Unit::TestCase
  def test_updating_simple_values
    statistic = Ripple::Statistics::Average.new(:key => 'test_average')
    statistic.key = 'test'

    statistic.update_with(10)
    assert_equal 1,    statistic.count
    assert_equal 10.0, statistic.average

    statistic.update_with(5)
    assert_equal 2,   statistic.count
    assert_equal 7.5, statistic.average

    statistic.update_with(12)
    assert_equal 3,  statistic.count
    assert_equal 9.0, statistic.average
  end

  def test_conflict_resolution_of_siblings
    key = 'average_siblings'
    siblings = []
    siblings[0] = Ripple::Statistics::Average.new(:key => key)
    siblings[0].key = key
    siblings[0].update_with 10

    3.times do
      siblings << Ripple::Statistics::Average.find(key)
    end

    siblings[1].update_with 10
    statistic = Ripple::Statistics::Average.find(key)
    assert_equal 2,    statistic.count
    assert_equal 10.0, statistic.average

    siblings[2].update_with 7
    statistic = Ripple::Statistics::Average.find(key)
    assert_equal 3,   statistic.count
    assert_equal 9.0, statistic.average

    siblings[3].update_with 13
    statistic = Ripple::Statistics::Average.find(key)
    assert_equal 4,    statistic.count
    assert_equal 10.0, statistic.average

    siblings[0].update_with 19
    statistic = Ripple::Statistics::Average.find(key)
    assert_equal 5,    statistic.count
    assert_equal 11.8, statistic.average

    siblings[0].update_with 13
    statistic = Ripple::Statistics::Average.find(key)
    assert_equal 6,    statistic.count
    assert_equal 12.0, statistic.average
  end
end
