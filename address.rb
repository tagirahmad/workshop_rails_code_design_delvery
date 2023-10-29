# frozen_string_literal: true

class Address
  attr_reader :city, :street, :house

  def initialize(city:, street:, house:)
    @city = city
    @street = street
    @house = house
  end
end
