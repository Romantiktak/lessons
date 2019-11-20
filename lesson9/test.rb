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

station_1 = Station.new(name: "Первая")
station_2 = Station.new(name: "Вторая")
station_3 = Station.new(name: "Третья")
station_4 = Station.new(name: "Четвертая")

route1 = Route.new(station_1, station_4)
route1.add_station(station_2)
route1.add_station(station_3)

route2 = Route.new(station_2, station_4)

train_cargo1 = CargoTrain.new("101", :company => "gruzrail")
train_cargo2 = CargoTrain.new("102", :company => "gaz")
train_passenger1 = PassengerTrain.new("201", :company => "pass")
train_passenger2 = PassengerTrain.new("202", :company => "rzd")

train_cargo1.route_train(route1)
train_passenger1.route_train(route2)

cargo_wagon = Array.new(5)
passenger_wagon = Array.new(5)

5.times do |i|
  cargo_wagon[i] = CargoWagon.new(:company => "cargo" + i.to_s, :free_volume => (i+1)*25)
  train_cargo1.add_wagon(cargo_wagon[i])
  passenger_wagon[i] = PassengerWagon.new(:company => "pass" + i.to_s, :free_seats => (i+1)*10)
  train_passenger1.add_wagon(passenger_wagon[i])
end

#puts "Созданный поезд #{train_cargo1}"

train_cargo1.each_wagon { |wagon| puts "Номер вагона: #{wagon.free_volume}, компания: #{wagon.company}" }
puts " -------- "
train_passenger1.each_wagon { |wagon| puts "Номер вагона: #{wagon.free_seats}, компания: #{wagon.company}" }

Train.trains.class
