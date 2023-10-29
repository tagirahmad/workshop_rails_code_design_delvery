# frozen_string_literal: true

class Truck
  TRUCKS = { kamaz: 3000, gazel: 1000 }.freeze

  def self.choose(weight)
    TRUCKS.keys.each { return _1 if TRUCKS[_1] > weight }

    nil
  end
end
