# frozen_string_literal: true

class Delivery
  ValidationError = Class.new StandardError

  attr_reader :truck, :weight, :order_number, :address, :date, :status, :error_message

  def initialize(opts = {})
    @truck = opts[:truck]
    @weight = opts[:weight]
    @order_number = opts[:order_number]
    @address = opts[:address]
    @date = opts[:date]

    @status = :ok  if validate
  end

  def success?
    @status == :ok
  end

  private

  def validate
    address.validate!
    validate_delivery_date!(date)
    validate_truck_presence!(truck)

    true
  rescue ValidationError => e
    @status = :error
    @error_message = e.to_s

    false
  end

  def validate_delivery_date!(delivery_date)
    raise ValidationError, 'Дата доставки уже прошла' if delivery_date < Date.today
  end

  def validate_truck_presence!(result)
    raise ValidationError, 'Нет машины' if result.nil?
  end
end