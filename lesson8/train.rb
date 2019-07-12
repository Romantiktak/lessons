class Train
  include BrandName
  include InstanceCounter
  include Validation
  attr_reader :speed, :wagons, :station, :index_station

  NUMBER_FORMAT = /^([a-zа-я]|\d){3}(\-([a-zа-я]|\d){2})?$/i

  @@trains = {}

  def initialize(number_train, company)
    @wagons = []
    @speed = 0
    @type = nil
    self.company = company
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
    if @index_station < @route_train.stations.size - 1
      @station.delete_train(self)
      @station = @route_train.stations[@index_station + 1]
      @index_station += 1
      @station.add_train(self)
    end
  end

  def previous_station
    if @index_station > 0
      @station.delete_train(self)
      @station = @route_train.stations[@index_station - 1]
      @index_station -= 1
      @station.add_train(self)
    end
  end

  def add_wagon(wagon)
    if wagon.valid? && @speed.zero? && @type == wagon.class && !@wagons.include?(wagon)
      @wagons << wagon
    end
    raise 'Вагон не может иметь пустое значение' if wagon.nil?
  end

  def delete_wagon(wagon)
    if @speed.zero? && !wagon.nil?
      @wagons.delete(wagon)
    end
    raise 'Вагон отсутствует' if wagon.nil?
  end

  def self.find(number_train)
    @@trains.each do |train,number|
      return train if number == number_train
    end
  end

  def self.number_train(object_train)
    @@trains.each do |train,number|
      return number if train == object_train
    end
  end

  def self.trains
    puts "#{@@trains}"
  end

  def what_station
    self.station.name
    raise 'Станция не может иметь Nill-значение ' if self.station.nil?
  end

  def each_wagon
    i = 0
    self.wagons.each {|wagon| puts "#{i+=1} -- "; yield(wagon) }
  end

  def how_many_wagons
    return self.wagons.size
  end

  protected
  def validate!
    raise "Компания не может быть пустой строкой" if self.company.length.zero?
    raise "Формат номера не соответствует" if @@trains[self] !~ NUMBER_FORMAT
  end
end

