# frozen_string_literal: true

require_relative 'truck'
require_relative 'error'

class Delivery
  attr_reader :truck, :weight, :order_number, :address, :date, :status

  def initialize(truck:, weight:, order_number:, address:, date:, status: nil, error_message: nil)
    @truck = truck
    @weight = weight
    @order_number = order_number
    @address = address
    @date = date
    @status = status
    @error_message = error_message

    validate

    @status = :ok
  end

  def success?
    @status == :ok
  end

  private

  def validate
    address.validate!
    validate_delivery_date!(date)
    validate_truck_presence!(truck)
  rescue Error::Validation => e
    @status = :error
    @error_message = e.to_s
  end

  def validate_delivery_date!(delivery_date)
    raise Error::Validation, 'Дата доставки уже прошла' if delivery_date < Date.today
  end

  def validate_truck_presence!(result)
    raise Error::Validation, 'Нет машины' if result.nil?
  end
end

class PrepareDelivery
  def initialize(order, user)
    @order = order
    @user = user
  end

  def perform(destination_address, delivery_date)
    Delivery.new(truck: Truck.find_proper(@order.sum),
                     weight: nil,
                     order_number: @order.id,
                     address: destination_address,
                     date: delivery_date)
  #   result = { truck: nil, weight: nil, order_number: @order.id, address: destination_address, status: :ok }
  #   result[:truck] = Truck.find_proper(@order.sum)
  #
  #   destination_address.validate!
  #   validate_delivery_date!(delivery_date)
  #   validate_truck_presence(result[:truck])
  #
  #   result
  # rescue Error::Validation => e
  #   result[:status] = :error
  #   result[:error_message] = e.to_s
  #
  #   result
  end

  private

  def validate_delivery_date!(delivery_date)
    raise Error::Validation, 'Дата доставки уже прошла' if delivery_date < Date.today
  end

  def validate_truck_presence(result)
    raise Error::Validation, 'Нет машины' if result.nil?
  end
end
