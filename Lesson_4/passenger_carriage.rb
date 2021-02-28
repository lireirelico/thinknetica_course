require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_accessor :places, :occupied_places

  def initialize(places = 10, capacity = 10, code = rand(10000..99999))
    super(capacity, code)
    @places = places
    @occupied_places = 0
  end

  def take_place
    return if free_places == 0
    @occupied_places += 1
  end

  def free_places
    @places - @occupied_places
  end
end