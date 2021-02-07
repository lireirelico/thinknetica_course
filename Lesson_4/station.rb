require_relative 'modules/instance_counter'

class Station
  attr_reader :name
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  def self.all
    @@all_stations
  end

  def take_train(train)
    @trains << train
  end

  def all_trains(type = nil)
    case type
    when "грузовой"
      @trains.find_all { |train| train.type.freight?  }
    when "пассажирский"
      @trains.find_all { |train| train.type.passenger?  }
    else
      @trains
    end
  end

  def send_train(train)
    @trains.delete(train)
  end
end