# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'order'

class TestOrder < Minitest::Test
  def setup
    @order = Order.new
  end

  def test_get_order_sum
    assert_equal 60, @order.sum
  end
end