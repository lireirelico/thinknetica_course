require_relative 'modules/company.rb'
require_relative 'modules/instance_counter'

class Train
  include Company
  include InstanceCounter

  @@all_trains = {}
  attr_reader :speed, :carriages, :current_station, :number, :route

  def initialize(number, carriage = [])
    @number = number
    @carriages = carriage
    @speed = 0
    @@all_trains[number] = self
    register_instance
    valid?
  end

  def each_carriage
    @carriages.each { |carriage| yield(carriage) }
  end

  def find(number)
    @@all_trains[number]
  end

  def speed_up(speed)
    @speed = speed
  end

  def slow_down
    @speed = 0
  end

  def attach_carriage(carriage)
    @carriages << carriage
  end

  def unhook_carriage
    @carriages.shift
  end

  def get_route(route)
    @route = route
    return unless check_route?
    @current_station = route.stations.first
    @current_station.take_train(self)
  end

  def move_forward
    return unless check_route?
    if @current_station == @route.stations.last
      puts 'Поезд находится на последней станции'.red
      return
    end

    @current_station.send_train(self)
    @current_station = next_station
    @current_station.take_train(self)
  end

  def move_back
    return unless check_route?
    if @current_station == @route.stations.first
      puts 'Поезд находится на первой станции'.red
      return
    end

    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.take_train(self)
  end

  protected

  def cargo?(carriage)
    carriage.class == CargoCarriage
  end

  def passenger?(carriage)
    carriage.class == PassengerCarriage
  end

  def check_route?
    @route ? true : false
  end

  private

  def valid?
    raise 'Не правильный формат номера поезда' unless number =~ /^[\w\d]{3}-*[\w\d]{2}$/i
    true
  end

  def get_station_number(station)
    @route.stations.get_station_number.index(station)
  end

  def next_station
    next_station_number = @route.get_station_number(@current_station) + 1
    @route.stations[next_station_number]
  end

  def previous_station
    previous_station_number = @route.get_station_number(@current_station) - 1
    @route.stations[previous_station_number]
  end
end
