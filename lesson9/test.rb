# frozen_string_literal: true

require_relative 'brand_name'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'rail_road'

station_1_id = Station.new(name: 'Первая')
station_2_id = Station.new(name: 'Вторая')
station_3_id = Station.new(name: 'Третья')
station_4_id = Station.new(name: 'Четвертая')

route1_id = Route.new(station_1_id, station_4_id)
route1_id.add_station(station_2_id)
route1_id.add_station(station_3_id)

route2_id = Route.new(station_2_id, station_4_id)

train_cargo1_id = CargoTrain.new('101', company: 'gruzrail')
train_cargo2_id = CargoTrain.new('102', company: 'gaz')
train_passenger1_id = PassengerTrain.new('201', company: 'pass')
train_passenger2_id = PassengerTrain.new('202', company: 'rzd')

train_cargo1_id.route_train(route1_id)
train_passenger1_id.route_train(route2_id)

cargo_wagon = Array.new(5)
passenger_wagon = Array.new(5)

5.times do |i|
  cargo_wagon[i] =
    CargoWagon.new(company: 'cargo' + i.to_s, free_volume: (i + 1) * 25)
  train_cargo1_id.add_wagon(cargo_wagon[i])
  passenger_wagon[i] =
    PassengerWagon.new(company: 'pass' + i.to_s, free_seats: (i + 1) * 10)
  train_passenger1_id.add_wagon(passenger_wagon[i])
end

train_cargo1_id.each_wagon do |wagon|
  puts "Wagon number: #{wagon.free_volume}, company is #{wagon.company}"
end
puts ' -------- '
train_passenger1_id.each_wagon do |wagon|
  puts "Wagon number: #{wagon.free_seats}, company is #{wagon.company}"
end

Train.trains.class
