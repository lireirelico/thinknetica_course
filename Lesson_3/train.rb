class Train
  attr_reader :speed, :carriage_count, :current_station, :type

  def initialize(number, carriage_count, type)
    @number = number
    @carriage_count = carriage_count
    @type = type
    @speed = 0
  end

  def speed_up(speed)
    @speed = speed
  end

  def slow_down
    @speed = 0
  end

  def attach_carriage
    @carriage_count += 1 if @speed.null?
  end

  def unhook_carriage
    @carriage_count -= 1 if @speed.null?
  end

  def get_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.take_train(self)
  end

  def passenger?
    @type == 'пассажирский'
  end

  def freight?
    @type == 'грузовой'
  end

  def move_forward
    return 'Нет маршрута' unless @route
    return 'Поезд находится на последней станции' if @current_station == @route.stations.last
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.take_train(self)
  end

  def move_back
    return 'Нет маршрута' unless @route
    return 'Поезд находится на первой станции' if @current_station == @route.stations.last
    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.take_train(self)
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

