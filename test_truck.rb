# frozen_string_literal: true

require 'minitest/autorun'

require_relative 'truck'

class TestPrepareDelivery < Minitest::Test
  def setup
    @truck = Truck
  end

  def test_choose_track
    result = @truck.find_proper(40)
    assert_equal :kamaz, result

    result = @truck.find_proper(4000)
    assert_equal nil, result
  end
end
