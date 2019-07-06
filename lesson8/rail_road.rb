class RailRoad
  include InstanceCounter
  include Validation
  attr_reader :trains, :wagons, :stations, :routes

  def initialize
    @trains = []
    @wagons = []
    @stations = []
    @routes = []
  end

  def start
    loop do
      puts 'Введите 0 чтобы выйти'
      puts 'Введите 1 чтобы создать станцию'
      puts 'Введите 2 чтобы создать поезд'
      puts 'Введите 3 чтобы создать маршрут'
      puts 'Введите 4 чтобы присвоить поезду маршрут'
      puts 'Введите 5 чтобы создать вагоны'
      puts 'Введите 6 чтобы добавить вагон к поезду '
      puts 'Введите 7 чтобы отцепить вагон от поезда'
      puts 'Введите 8 чтобы переместить поезд на другую станцию'
      puts 'Введите 9 чтобы отобразить список станций'
      puts 'Введите 10 чтобы отобразить список поездов'
      puts 'Введите 11 чтобы найти поезд'
      puts 'Введите 12 чтобы узнать количество экземпларов классов'
      puts 'Введите 13 чтобы отобразить список вагонов у поезда'
      menu = gets.chomp.to_i
      case menu
      when 0
        break
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        add_train_on_route
      when 5
        create_wagons
      when 6
        add_wagon_to_train
      when 7
        delete_wagon_from_train
      when 8
        move_train_to_station
      when 9
        show_stations
      when 10
        show_trains
      when 11
        find_train
      when 12
        objects_of_classes
      when 13
        list_wagons_of_train
        find_train { |item| puts "#{item}" }
      else
        puts 'Некорректный ввод'
      end
    end
 end

  # создание станций
  def create_station
    puts 'Введите название для создания станции или Enter для выхода'
    st_name = gets.chomp
    if st_name.length.zero?
      start
    else
      @stations << Station.new(st_name)
      puts "Создана станция #{@stations.last}"
      create_station
    end
  end

  # создание поездов
  def create_train
    puts 'Введите 0 для выхода'
    puts 'Введите 1 для создания пассажирского поезда'
    puts 'Введите 2 для создания грузового поезда'
    type = gets.chomp.to_i
    case type
    when 0
      start
    when 1
      puts 'Введите номер пассажирского поезда'
      number = gets.chomp
      puts "Введите название компании поезда"
      company = gets.chomp
      add_train_type(PassengerTrain, number, company)
    when 2
      puts "Введите номер грузового
      поезда"
      number = gets.chomp
      puts "Введите название компании поезда"
      company = gets.chomp
      add_train_type(CargoTrain, number, company)
    else
      create_train
    end
  rescue
    puts 'Train did not create'
  end

  # создавать поезд, если данные валидны
  def add_train_type(type_train, number, company)
    if @trains << type_train.new(number, company)
      puts "Создан поезд #{@trains.last}"
    else
      puts "Поезд не создан"
    end
  end

  # создание маршрутов
  def create_route
    show_stations
    puts 'Введите номер первой станции маршрута'
    first_index_station = gets.chomp.to_i
    valid_zero(first_index_station)
    puts 'Введите номер конечной станции марщрута'
    last_index_station = gets.chomp.to_i
    valid_zero(last_index_station)
    @routes << Route.new(@stations[first_index_station - 1], @stations[last_index_station - 1])
    puts 'Маршрут создан!!!'
    puts 'Введите номера станций для добавления через запятую или Enter для выхода'
    st_name = gets.chomp
    if st_name.length.zero?
      start
    else
      st_name.split(',').map! { |x| x.to_i }.each do |i|
        @routes.last.add_station(@stations[i - 1])
      end
    end
  rescue
    puts 'Error: Route did not create'
  end

  # добавление поезда на маршрут
  def add_train_on_route
    show_routes
    puts 'Введите номер маршрута'
    route_index = gets.chomp.to_i
    message_input_number(@routes, route_index)
    show_trains
    puts 'Введите номер поезда для маршрута'
    train_index = gets.chomp.to_i
    message_input_number(@trains, train_index)
    @trains[train_index - 1].route_train(@routes[route_index - 1])
    puts 'Train added on route'
  rescue
    puts 'Error: did not add train'
  end

  # вывод списка станций
  def show_stations
    message_return_start(@stations, 'Станции')
    @stations.each_with_index do |station, index|
      puts "#{index + 1}: #{station.name}"
    end
  rescue
    puts 'Error: Station are not absent'
  end

  # Вывод списка поездов
  def show_trains
    message_return_start(@trains, 'поезда')
    @trains.each_with_index do |train, index|
      puts "#{index + 1}: №#{train}"
    end
  end

  # Вывод списка маршрутов
  def show_routes
    message_return_start(@routes, 'маршрута')
    @routes.each_with_index do |route, index|
      puts "#{index + 1}: #{route} кол-во станций #{route.stations.size}"
    end
  end

  # Вывод списка вагонов
  def show_wagons(train)
    message_return_start(@wagons, 'Вагонов')
    if train.class == PassengerTrain
      class_type = PassengerWagon
    elsif train.class == CargoTrain
      class_type = CargoWagon
    end
    @wagons.each_with_index do |wagon, index|
      puts "#{index + 1}: #{wagon} #{wagon.company}" if wagon.class == class_type
    end
  end

  # Создание вагонов
  def create_wagons
    puts 'Введите 1 для создания пассажирских вагонов'
    puts 'Введите 2 для создания грузовых вагонов'
    puts 'Введите 0 для выхода'
    type = gets.chomp.to_i
    return_menu_if_zero(type)
    puts 'Сколько вагонов создать?'
    count = gets.chomp.to_i
    puts 'Какой фирмы эти вагоны?'
    company = gets.chomp
    if type == 1
      puts 'Введите количество пассажирских мест'
      seats = gets.chomp.to_i
      count.times do
        @wagons << PassengerWagon.new(company, seats)
      end
    elsif type == 2
      puts 'Введите объем вагона в натуральных единицах'
      volume = gets.chomp.to_i
      count.times do
        @wagons << CargoWagon.new(company, volume)
      end
    else
      puts "Неправильный ввод действия"
      start
    end
    puts "Создано вагонов = #{count}"
    raise 'Введено не натуральное число в поле количества вагонов' if count < 1
  rescue
    puts  'Wagons did not create'
  end

  # Прицепить вагон к поезду
  def add_wagon_to_train
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i
    valid_zero(train_index)
    show_wagons(@trains[train_index - 1])
    puts 'Введите номера вагонов через запятую'
    wagons_index = gets.chomp.split(',')
    raise 'Номера вагонов не введены' if wagons_index.empty?
    wagons_index.each do |i|
      @trains[train_index - 1].add_wagon(@wagons[i.to_i - 1])
    end
  rescue
    puts 'Did not add wagon'
  end

  # Отцепить вагон от поезда
  def delete_wagon_from_train
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i
    unless @trains[train_index - 1].wagons.empty?
      puts 'Перечислите через запятую номера вагонов, которые нужно отцепить:'
      @trains[train_index - 1].wagons.each_with_index do |wagon, index|
        puts "#{index + 1}: #{wagon}"
      end
      wagons_index = gets.chomp.split(',').map! { |x| x = x.to_i }
      wagons_index.reverse_each do |i|
        wagon_delete = @trains[train_index - 1].wagons[i - 1]
        @trains[train_index - 1].delete_wagon(wagon_delete)
      end
    else
      puts "Нет доступных вагонов для отцепки"
      start
    end
  rescue
    puts 'Did not delete wagon'
  end

  # Переместить поезд на следующую станцию
  def move_train_to_station
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i
    loop_move_train(train_index)
  end

  # Цикл с выводом меню для перемещения поезда
  def loop_move_train(train_index)
    @trains[train_index - 1].what_station
    puts 'Введите 0 для выхода'
    puts 'Введите 1 для перемещения поезда на следующую станцию'
    puts 'Введите 2 для перемещения поезда на предыдущую станцию'
    move = gets.chomp.to_i
    case move
    when 0
      start
    when 1
      @trains[train_index - 1].next_station
      loop_move_train(train_index)
    when 2
      @trains[train_index - 1].previous_station
      loop_move_train(train_index)
    else
      move_train_to_station
    end
  rescue
    puts 'Ошибка: Нельзя переместить поезд!'
  end

  # Поиск поезда по номеру
  def find_train
    puts 'Введите номер поезда'
    number = gets.chomp
    puts Train.find(number)
  end

  def list_wagons_of_train
    show_trains
    puts 'Введите номер поезда'
    number = gets.chomp.to_i
    @trains[number - 1].wagon_to_block { |wagon| puts "вагон #{wagon} #{wagon.company}" }
  end

  # Вывод количество экземпляров класса
  def objects_of_classes
    puts "Создано экземпляров CargoTrain: #{CargoTrain.instances}"
    puts "Создано экземпляров PassengerTrain: #{PassengerTrain.instances}"
    puts "Создано экземпляров Route: #{Route.instances}"
    puts "Создано экземпляров station: #{Station.instances}"
  end

  def return_menu_if_zero(number)
    start if number.zero?
  end

  def message_return_start(object, name_class)
    unless object.length.zero?
      puts "Список имеющихся #{object.first.class}"
    else
      puts "Не создано ниодного экземпляра #{name_class}"
      start
    end
  end

  def message_input_number(array, number)
    raise "номер за рамками диапазона" if number > array.length || number < 1
  end
end

