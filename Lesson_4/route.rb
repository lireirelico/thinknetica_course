class Route
  attr_reader :stations

  def initialize(starting_station, end_station)
    @stations = [starting_station, end_station]
  end

  def add_intermediate_station(name)
    @stations.insert(-2, name)
  end

  def delete_intermediate_station(name)
    @stations.delete(name)
  end

  def get_station_number(station)
    @stations.index(station)
  end

  def station_list
    @stations.map { |station| station.name }
  end

  def name
    "'#{@stations.first.name}' - '#{@stations.last.name}'"
  end
end