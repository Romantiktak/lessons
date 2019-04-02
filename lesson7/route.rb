class Route
  include InstanceCounter
  include Validation
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    raise 'Станция отсутсвует' if station.nil?
    unless @stations.include?(station)
      @stations.insert(-2, station)
      puts 'Станция #{station} добавлена в маршрут'
    else
      puts 'Станция не добавлена в маршрут'
    end
  rescue
    puts 'Станция не добавлена в маршрут'
  end

  def delete_station(name)
    @stations.delete(name) unless (@stations.first == name) || (@stations.last == name)
  end

  protected
  def validate!
    raise "stations should be created" if self.stations[0].nil? || self.stations[-1].nil?
    raise "Нельзя дублировать станции в маршруте" if self.stations[0] == self.stations[-1]
    self.stations.each do |station|
      raise "You inputed station nocorrect" unless station.class == Station
    end
  end
end
