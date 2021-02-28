require_relative 'carriage'

class CargoCarriage < Carriage
  attr_accessor :occupied_capacity

  def initialize(capacity = 10, code = rand(10000..99999))
    super(capacity, code)
    @occupied_capacity = 0
  end

  def take_volume(volume)
    return if free_capacity >= 0
    @occupied_capacity += volume
  end

  def free_capacity
    @capacity - @occupied_capacity
  end
end