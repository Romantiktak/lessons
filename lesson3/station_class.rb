class Stantion()
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    self.trains << train
    train.train_stantion = self
  end

  def show_trains_on_station
    self.trains.each {|train| puts train.object_id.to_s}
  end

  def delete_train(train)
    self.trains.delete(train)
    self.trains.each {|t| t.delete_stantion(trains) if t == train}
  end

  def amount_trains(type_index)
    count = 0
    type_train = Train::TYPE[type_index]
    self.trains.each do |train|
      if train.type_train == type_train
        count += 1
        puts train
      end
    end
    puts "Amount of trains by type #{type_train} = " + count.to_s
  end

end

class Route
  attr_reader :stantions

  def initialize(first,last)
    @stantions = [first,last]
  end

  #Добавляем станции последовательно от станции отправки
  def add_stantion(name)
    @stantions.insert(-2, name) unless @stantions.include?(name)
  end

  def delete_stantion(name)
    @stantions.delete(name) unless ((@stantions.first == name) || (@stantions.last == name))
  end

  def show_all_route
     @stantions.each {|station| puts station.name}
     puts "count= " + @stantions.size.to_s
  end
end

class Train
  #attr_writer :train_stantion
  attr_reader :number_train, :type_train, :route_train
  attr_accessor :speed, :wagons, :train_stantion
  TYPE = [:passanger, :cargo]
  def initialize(number_train, index_type, wagons = 1)
    @number_train = number_train
    @type_train = TYPE[index_type]
    @wagons = wagons
    @speed = 0
  end

  def add_speed(count = 10)
    self.speed += count
  end

  def current_speed
  puts self.speed
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    self.wagons +=1 if self.speed.zero?
  end

  def delete_wagon
    self.wagons -=1 if (self.speed.zero? && self.wagons > 0)
  end

  def set_route_train(route)
    @route_train = route
    @train_stantion = route.stantions.first
    self.train_stantion.add_train(self)
    puts "train on stantion " + self.train_stantion.name
  end

  def delete_station
     self.train_stantion = nil unless self.train_stantion.nil?
  end


  def to_last_step_station
    self.train_stantion.delete_train(self)
    self.train_stantion = self.route_train.stantions[index_station+1] if index_station < route_train.stantions.size
    self.train_stantion.add_train(self)
    puts self.train_stantion.name
  end

  def to_first_step_station
  self.train_stantion.delete_train(self)
  self.train_stantion = self.route_train.stantions[index_station-1] if index_station >= 0
  self.train_stantion.add_train(self)
  end

  def index_station
    i = self.route_train.stantions.index(self.train_stantion)
    return i if (i >= 0) && (i <= self.route_train.stantions.size)
  end

  def info_station
    puts "Текущая станция " +  self.train_stantion.name
    puts "Хотите узнать следующую станцию, введите 'next'"
    puts "Хотите узнать предыдущую станцию, введите 'previous'"
    what_station = gets.chomp

    case what_station
    when 'next'
      puts "Next station name " + self.route_train.stantions[index_station+1].name
    when 'previous'
      puts "Next station name " + self.route_train.stantions[index_station-1].name
    else
      puts "No correct date"
    end

  end

end


