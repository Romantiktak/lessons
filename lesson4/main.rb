require_relative 'stantion'
require_relative 'route'
require_relative 'wagon'
require_relative 'train'

arkhangelsk = Stantion.new('Архангельск')
vologda = Stantion.new('Вологда')
yaroslavl = Stantion.new('Ярославль')
moskva = Stantion.new('Москва')
route_nord = Route.new(arkhangelsk, moskva)
route_nord.add_stantion(vologda)
route_nord.add_stantion(yaroslavl)
n_novgorod = Stantion.new('Нижний Новгород')
kazan = Stantion.new('Казань')
ekaterinburg = Stantion.new('Екатеринбург')
route_east = Route.new(moskva, ekaterinburg)
route_east.add_stantion(n_novgorod)
route_east.add_stantion(kazan)

wp1 = PassengerWagon.new
wp2 = PassengerWagon.new
wc1 = CargoWagon.new
wc2 = CargoWagon.new

train_pass = PassengerTrain.new(111)
train_cargo = CargoTrain.new(222)
train_pass.route_train(route_nord)
train_cargo.route_train(route_east)
train_pass.add_wagon(wp1)
train_cargo.add_wagon(wc1)
