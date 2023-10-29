# frozen_string_literal: true

class PrepareDelivery
  TRUCKS = { kamaz: 3000, gazel: 1000 }.freeze

  def initialize(order, user)
    @order = order
    @user = user
  end

  def perform(destination_address, delivery_date)
    result = { truck: nil, weight: nil, order_number: @order.id, address: destination_address, status: :ok }

    validate!(destination_address, delivery_date)

    weight = @order.products.map(&:weight).sum
    TRUCKS.keys.each { |key| result[:truck] = key if TRUCKS[key.to_sym] > weight }
    
    raise 'Нет машины' if result[:truck].nil?

    result
  rescue StandardError => e
    result[:status] = :error
    result[:error_message] = e.to_s
  ensure
    return result
  end

  private

  def validate!(destination_address, delivery_date)
    raise 'Дата доставки уже прошла' if delivery_date < Date.today
    raise 'Нет адреса' if destination_address.city.empty? || destination_address.street.empty? || destination_address.house.empty?
  end
end
