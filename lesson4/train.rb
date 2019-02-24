class Train
  attr_reader :number_train, :speed, :wagons, :stantion, :index_station
  def initialize(number_train)
    @number_train = number_train
    @wagons = []
    @speed = 0
  end

  def add_speed(count = 10)
    @speed += count if (@speed + count) >= 0
  end

  def stop
    @speed = 0
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

  protected
#add_wagon, delete_wagon необходимо переопределить для того
#чтобы добавлять и удалять только соответсвующие типы вагонов
  def add_wagon(wagon)
    @wagons << wagon if @speed.zero?
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end

end
