# frozen_string_literal: true

require_relative 'error'

class Address
  attr_reader :city, :street, :house

  ERROR_TEXTS = { 'Нет города' => :city, 'Нет улицы' => :street, 'Нет дома' => :house }.freeze

  def initialize(city:, street:, house:)
    @city = city
    @street = street
    @house = house
  end

  def validate!
    ERROR_TEXTS.each { |error, attribute| raise Error::Validation, error if send(attribute).empty? }
  end
end
