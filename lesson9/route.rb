# frozen_string_literal: true

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
    return nil if @stations.include?(station)

    @stations.insert(-2, station)
  end

  def delete_station(name)
    @stations.delete(name) unless (@stations.first == name) || (@stations.last == name)
  end

  protected

  def validate!
    raise 'Станция должна быть создана' if stations[0].nil? || stations[-1].nil?
    raise 'Нельзя дублировать станции в маршруте' if stations[0] == stations[-1]

    stations.each do |station|
      raise 'Ты вставил станцию некорректно' unless station.class == Station
    end
  end
end
