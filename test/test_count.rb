require 'helper'

class TestCount < Test::Unit::TestCase
  def test_updating_simple_values
    statistic = Ripple::Statistics::Count.new(:key => 'test_count')
    statistic.key = 'test'

    statistic.update_with(10)
    assert_equal 1,    statistic.count

    statistic.update_with(5)
    assert_equal 2,   statistic.count

    statistic.update_with(12)
    assert_equal 3,  statistic.count
  end

  def test_conflict_resolution_of_siblings
    key = 'count_siblings'
    siblings = []
    siblings[0] = Ripple::Statistics::Count.new(:key => key)
    siblings[0].key = key
    siblings[0].update_with 10

    3.times do
      siblings << Ripple::Statistics::Count.find(key)
    end

    siblings[1].update_with 10
    statistic = Ripple::Statistics::Count.find(key)
    assert_equal 2,    statistic.count

    siblings[2].update_with 7
    statistic = Ripple::Statistics::Count.find(key)
    assert_equal 3,   statistic.count

    siblings[3].update_with 13
    statistic = Ripple::Statistics::Count.find(key)
    assert_equal 4,    statistic.count

    siblings[0].update_with 19
    statistic = Ripple::Statistics::Count.find(key)
    assert_equal 5,    statistic.count

    siblings[0].update_with 13
    statistic = Ripple::Statistics::Count.find(key)
    assert_equal 6,    statistic.count
  end
end
