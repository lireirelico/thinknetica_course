class Station
  def initialize(name)
    @name = name
    @trains = []
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