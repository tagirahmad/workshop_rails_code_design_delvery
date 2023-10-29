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

    weight = @order.sum
    result[:truck] = choose_track(weight)
    validate_truck(result[:truck])

    result
  rescue StandardError => e
    result[:status] = :error
    result[:error_message] = e.to_s

    result
  end

  def choose_track(weight)
    TRUCKS.keys.each { return _1 if TRUCKS[_1] > weight }

    nil
  end

  private

  def validate!(destination_address, delivery_date)
    raise 'Дата доставки уже прошла' if delivery_date < Date.today

    if destination_address.city.empty? || destination_address.street.empty? || destination_address.house.empty?
      raise 'Нет адреса'
    end
  end

  def validate_truck(result)
    raise 'Нет машины' if result.nil?
  end
end
