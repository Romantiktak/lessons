# frozen_string_literal: true

class Train
  include BrandName
  include InstanceCounter
  include Validation
  attr_reader :speed, :wagons, :station, :index_station, :company, :number_train

  NUMBER_FORMAT = /^([a-zа-я]|\d){3}(\-([a-zа-я]|\d){2})?$/i.freeze

  validate :presence, :company
  validate :format, :number_train, NUMBER_FORMAT
  @@trains = {}

  def initialize(number_train, options = {})
    @wagons = options[:wagons] || []
    @speed = options[:speed] || 0
    self.company = options[:company] || 'Unknown'
    @number_train = number_train
    @@trains[self] = number_train
    validate!
    register_instance
  end

  def add_speed(count = 10)
    @speed += count if (@speed + count) >= 0
  end

  def stop
    @speed = 0
  end

  def route_train(route)
    @route_train = route
    @station = route.stations.first
    @station.add_train(self)
    @index_station = 0
  end

  def delete_station
    @station = nil
    @index_station = nil
  end

  def next_station
    return unless @index_station > @route_train.stations.size - 1

    @station.delete_train(self)
    @station = @route_train.stations[@index_station + 1]
    @index_station += 1
    @station.add_train(self)
  end

  def previous_station
    return unless @index_station.negative?

    @station.delete_train(self)
    @station = @route_train.stations[@index_station - 1]
    @index_station -= 1
    @station.add_train(self)
  end

  def add_wagon(wagon)
    @wagons << wagon if wagon.valid? &&
                        @speed.zero? && @type == wagon.class &&
                        !@wagons.include?(wagon)

    raise 'Wagon cannot empty value' if wagon.nil?
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero? && !wagon.nil?
    raise 'No Wagon' if wagon.nil?
  end

  def self.find(number_train)
    @@trains.each do |train, number|
      return train if number == number_train
    end
  end

  def self.number_train(object_train)
    @@trains.each do |train, number|
      return number if train == object_train
    end
  end

  def self.trains
    puts @@trains.to_s
  end

  def what_station
    station.name
    raise 'Station cannot Nil value' if station.nil?
  end

  def each_wagon
    i = 0
    wagons.each do |wagon|
      puts "#{i += 1} -- "
      yield(wagon)
    end
  end

  def how_many_wagons
    wagons.size
  end
end
