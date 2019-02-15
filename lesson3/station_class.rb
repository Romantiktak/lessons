class Stantion
  attr_reader :trains
  attr_accessor :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def type_train
    passanger = 0
    cargo = 0
    @trains.each do |train|
      passanger += 1 if train.type == :passanger
      cargo += 1 if train.type == :cargo
    end
    { :passanger => passanger, :cargo => cargo }
  end
end

class Route
  attr_reader :stantions

  def initialize(first_stantion, last_stantion)
    @stantions = [first_stantion, last_stantion]
  end

  def add_stantion(stantion)
    @stantions.insert(-2, stantion) unless @stantions.include?(stantion)
  end

  def delete_stantion(name)
    @stantions.delete(name) unless (@stantions.first == name) || (@stantions.last == name)
  end
end

class Train
  attr_reader :number_train, :type, :speed, :wagons, :stantion, :index_station
  # type = [:passanger, :cargo]
  def initialize(number_train, type, wagons = 1)
    @number_train = number_train
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def add_speed(count = 10)
    @speed += count if (@speed + count) >= 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed.zero?
  end

  def delete_wagon
    @wagons -= 1 if @speed.zero? && @wagons > 0
  end

  def route_train(route)
    @route_train = route
    @stantion = route.stantions.first
    @stantion.add_train(self)
    @index_station = 0
  end

  def delete_station
    @stantion = nil
    @index_station = nil
  end

  def got_to_next_station
    if next_station
      @stantion.delete_train(self)
      @stantion = next_station
      @index_station += 1
      @stantion.add_train(self)
    end
  end

  def got_to_previous_station
    if previous_station
      @stantion.delete_train(self)
      @stantion = previous_station
      @index_station -= 1
      @stantion.add_train(self)
    end
  end

  def next_station
    return @route_train.stantions[@index_station + 1] if @index_station < @route_train.stantions.size - 1
  end

  def previous_station
    return @route_train.stantions[@index_station - 1] if @index_station > 0
  end
end
