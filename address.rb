# frozen_string_literal: true

class Address
  attr_reader :city, :street, :house

  def initialize(city:, street:, house:)
    @city = city
    @street = street
    @house = house
  end

  def validate!
    raise 'Нет адреса' if city.empty? || street.empty? || house.empty?
  end
end
