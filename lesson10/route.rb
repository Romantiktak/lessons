# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation
  attr_accessor :stations

  validate :type_class, :stations, Station

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
end
