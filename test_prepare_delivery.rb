# frozen_string_literal: true

require 'minitest/autorun'
require 'ostruct'
require 'date'

require_relative 'prepare_delivery'
require_relative 'delivery'
require_relative 'address'
require_relative 'order'

class TestPrepareDelivery < Minitest::Test
  def setup
    @prepare_delivery = PrepareDelivery.new(Order.new, OpenStruct.new)
    @address = Address.new(city: 'Ростов-на-Дону', street: 'ул. Маршала Конюхова', house: 'д. 5')
    @invalid_address = Address.new(city: '', street: 'ул. Маршала Конюхова', house: 'д. 5')
  end

  def test_perform_success_with_valid_data
    result = @prepare_delivery.perform(@address, Date.today)

    assert_kind_of Delivery, result
    assert_equal true, result.success?
  end

  def test_perform_fail_with_invalid_data
    result = @prepare_delivery.perform(@address, Date.today - 1)

    assert_kind_of Delivery, result
    assert_equal :error, result.status
    assert_equal 'Дата доставки уже прошла', result.error_message

    result = @prepare_delivery.perform(@invalid_address, Date.today)

    assert_kind_of Delivery, result
    assert_equal :error, result.status
    assert_equal 'Нет города', result.error_message
  end
end
