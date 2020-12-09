require_relative 'train'

class CargoTrain < Train
  def attach_carriage(carriage = CargoCarriage.new)
    @carriages << carriage
  end
end