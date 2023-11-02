# frozen_string_literal: true

require_relative 'truck'

class PrepareDelivery
  def initialize(order, user)
    @order = order
    @user = user
  end

  def perform(destination_address, delivery_date)
    Delivery.new(truck: Truck.find_proper(@order.sum),
                 order_number: @order.id,
                 address: destination_address,
                 date: delivery_date)
  end
end
