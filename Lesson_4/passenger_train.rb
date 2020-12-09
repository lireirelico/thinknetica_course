require_relative 'train'

class PassengerTrain < Train
  def attach_carriage(carriage = PassengerCarriage.new)
    @carriages << carriage
  end
end