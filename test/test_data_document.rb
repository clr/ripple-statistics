require 'helper'
require 'data_document'

# DataDocument is a test class, so it is defined in this dir

class TestParallelStatistics < Test::Unit::TestCase
  def setup
    pids = []
    # start some external clients to add values to the Riak server
    5.times do |t|
      pids << fork {
        `bundle exec rake test_purposes_only:create_data_points ROW=#{t} RIPPLE_CLIENT_NAME=local#{t}`
      }
    end
    pids.each do |pid|
      Process.waitpid(pid)
    end
  end

  def test_concurrent_average
    assert_equal 49.397,     DataDocument.value_average.round(3)
    assert_equal 5000,       DataDocument.value_count
    assert_equal 246982.800, DataDocument.value_sum.round(3)
  end
end
