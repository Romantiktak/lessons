class Stantion
  attr_reader :trains
  attr_accessor :name, :type_trains

  def initialize(name)
    @name = name
    @trains = []
    @type_trains = { passanger: 0, cargo: 0 }
  end

  def add_train(train)
    @trains << train
    @type_trains[train.type_train] += 1
  end

  def delete_train(train)
    @trains.delete(train)
    @type_trains[train.type_train] -= 1
  end

  def all_train
    @type_trains[:passanger] + @type_trains[:cargo]
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
  attr_writer :index_station
  attr_reader :number_train, :type_train, :speed, :wagons, :stantion, :index_station
  # type_train = [:passanger, :cargo]
  def initialize(number_train, type_train, wagons = 1)
    @number_train = number_train
    @type_train = type_train
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
    next_st = next_station
    unless next_st.nil?
      @stantion.delete_train(self)
      @stantion = next_st
      @index_station += 1
      @stantion.add_train(self)
    end
  end

  def got_to_previous_station
    previous_st = previous_station
    unless previous_st.nil?
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
