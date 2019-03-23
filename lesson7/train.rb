class Train
  include BrandName
  include InstanceCounter
  include Validation
  attr_reader :speed, :wagons, :stantion, :index_station
  NUMBER_FORMAT = /^([a-zа-я]|\d){3}(\-([a-zа-я]|\d){2})?$/i
  @@trains = {}
  def initialize(number_train, company)
    @wagons = []
    @speed = 0
    @type = nil
    self.company = company
    register_instance
    @@trains[self] = number_train
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

  def next_station
    if @index_station < @route_train.stantions.size - 1
      @stantion.delete_train(self)
      @stantion = @route_train.stantions[@index_station + 1]
      @index_station += 1
      @stantion.add_train(self)
    end
  end

  def previous_station
    if @index_station > 0
      @stantion.delete_train(self)
      @stantion = @route_train.stantions[@index_station - 1]
      @index_station -= 1
      @stantion.add_train(self)
    end
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && @type == wagon.class
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end

  def self.find(number_train)
    @@trains[self] = number_train
    @@trains.each do |train,number|
      puts "#{@@trains[train]}" if number == number_train
    end
  end

  def self.trains
    puts "#{@@trains}"
  end

  protected
  def validate!
    raise "Comhany can't be empty String" if self.company.length.zero?
    raise "Format number isn't match" if @@trains[self] !~ NUMBER_FORMAT
  end
end

