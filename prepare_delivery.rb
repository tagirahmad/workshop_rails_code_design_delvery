# frozen_string_literal: true

require_relative 'truck'

class PrepareDelivery
  def initialize(order, user)
    @order = order
    @user = user
  end

  def perform(destination_address, delivery_date)
    result = { truck: nil, weight: nil, order_number: @order.id, address: destination_address, status: :ok }
    result[:truck] = Truck.choose(@order.sum)

    destination_address.validate!
    validate_delivery_date!(delivery_date)
    validate_truck_presence(result[:truck])

    result
  rescue StandardError => e
    result[:status] = :error
    result[:error_message] = e.to_s

    result
  end

  private

  def validate_delivery_date!(delivery_date)
    raise 'Дата доставки уже прошла' if delivery_date < Date.today
  end

  def validate_truck_presence(result)
    raise 'Нет машины' if result.nil?
  end
end
