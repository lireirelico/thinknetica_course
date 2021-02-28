require_relative 'modules/instance_counter'

class Station
  include InstanceCounter

  attr_reader :name
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  def each_train
    return unless @trains.any?
    @trains.each { |train| yield(train) }
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

=begin
require_relative 'train'
require 'pry'
tmp = Station.new('Station 1')
train1 = Train.new('123-QW')
train2 = Train.new('456-ER')
train3 = Train.new('789-TY')
tmp.take_train(train1)
tmp.take_train(train2)
tmp.take_train(train3)
tmp.each_train { |train| p train }
binding.pry
p 'a'
=end
