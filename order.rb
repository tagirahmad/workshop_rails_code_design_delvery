# frozen_string_literal: true

require 'ostruct'

class Order
  def id
    'id'
  end

  def products
    [OpenStruct.new(weight: 20), OpenStruct.new(weight: 40)]
  end

  def sum
    products.sum(&:weight)
  end
end
