class RailRoad
  attr_reader :trains, :wagons, :stantions, :routes

  def initialize
    @trains = []
    @wagons = []
    @stantions = []
    @routes = []
  end

   def start
    loop do
      puts "Введите 0 чтобы выйти"
      puts "Введите 1 чтобы создать станцию"
      puts "Введите 2 чтобы создать поезд"
      puts "Введите 3 чтобы создать маршрут"
      puts "Введите 4 чтобы присвоить поезду маршрут"
      puts "Введите 5 чтобы создать вагоны"
      puts "Введите 6 чтобы добавить вагон к поезду "
      puts "Введите 7 чтобы отцепить вагон от поезда"
      puts "Введите 8 чтобы переместить поезд на другую станцию"
      puts "Введите 9 чтобы отобразить список станций"
      puts "Введите 10 чтобы отобразить список поездов"
      menu = gets.chomp.to_i
      case menu
      when 0
        break
      when 1
        create_stantion
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
        show_stantions
      when 10
        show_trains
      else
        puts "Некорректный ввод"
      end
    end
  end

  def create_stantion
    loop do
      puts "Введите название для создания станции или Enter для выхода"
      st_name = gets.chomp
      if st_name.length.zero?
        break
      else
      @stantions << Stantion.new(st_name)
      end
    end
  end

  def create_train
    loop do
      puts "Введите 0 для выхода"
      puts "Введите 1 для создания пассажирского поезда"
      puts "Введите 2 для создания грузового поезда"
      type = gets.chomp.to_i
      case type
      when 0
        break
      when 1
        puts "Введите номер пассажирского поезда"
        number = gets.chomp.to_i
        @trains << PassengerTrain.new(number)
      when 2
        puts "Введите номер грузового
        поезда"
        number = gets.chomp.to_i
        @trains << CargoTrain.new(number)
      else
        puts "Поезд не создан, некорректный ввод"
      end

    end
  end

  def create_route
    show_stantions
    puts "Введите номер первой станции маршрута"
    first_index_stantion = gets.chomp.to_i
    puts "Введите номер конечной станции марщрута"
    last_index_station = gets.chomp.to_i
    @routes << Route.new(@stantions[first_index_stantion - 1], @stantions[last_index_station - 1])
    puts "Маршрут создан!!!"
    loop do
      puts "Введите номер станции для добавления или 0 для выхода"
      st_name = gets.chomp.to_i
      if st_name.zero?
        break
      else
        @routes.last.add_stantion(@stantions[st_name - 1])
      end
    end
  end

  def add_train_on_route
    show_routes
    puts "Введите номер маршрута"
    route_index = gets.chomp.to_i

    show_trains
    puts "Введите номер поезда для маршрута"
    train_index = gets.chomp.to_i

    @trains[train_index - 1].route_train(@routes[route_index - 1])
    puts "Train added on route"
  end

  def show_stantions
    puts "Вывод списка стаций"
    @stantions.each_with_index {|stantion, index| puts "#{index + 1}: #{stantion.name}"}
  end

  def show_trains
    puts "Список всех поездов"
    @trains.each_with_index do |train, index|
      puts "#{index + 1}: №#{train.number_train} Тип #{train.class}"
    end
  end

  def show_routes
    puts "Список имеющихся маршрутов"
    @routes.each_with_index do |route, index|
      puts "#{index + 1}: #{route} кол-во станций #{route.stantions.size}"
    end
  end

  def show_wagons(train)
    puts "Список доступных вагонов"
    if train.class == PassengerTrain
      class_type = PassengerWagon
    elsif train.class == CargoTrain
      class_type = CargoWagon
    end
    @wagons.each_with_index do |wagon,index|
      puts "#{index + 1}: #{wagon}" if wagon.class == class_type
    end
  end

  def create_wagons
    loop do
      puts "Введите 0 для выхода"
      puts "Введите 1 для создания пассажирских вагонов"
      puts "Введите 2 для создания грузовых вагонов"
      type = gets.chomp.to_i
      break if type.zero?
      puts "Сколько вагонов создать?"
      count = gets.chomp.to_i
      if type == 1
        count.times do
          @wagons << PassengerWagon.new
        end
      elsif type == 2
        count.times do
          @wagons << CargoWagon.new
        end
      else
        puts "no correct"
      end
    end
  end

  def add_wagon_to_train
    show_trains
    puts "Введите номер поезда"
    train_index = gets.chomp.to_i
    show_wagons(@trains[train_index - 1])
    puts "Введите номера вагонов через запятую"
    wagons_index = gets.chomp.split(",")
    wagons_index.each do |i|
      @trains[train_index - 1].add_wagon(@wagons[i.to_i - 1])
    end
  end

  def delete_wagon_from_train
    show_trains
    puts "Введите номер вагона"
    train_index = gets.chomp.to_i
    puts "Перечислите через запятую номера вагонов, которые нужно отцепить:"
    @trains[train_index - 1].wagons.each_with_index do |wagon ,index|
      puts "#{index + 1}: #{wagon}"
    end
    wagons_index = gets.chomp.split(",").map! {|x| x = x.to_i}
    wagons_index.reverse_each do |i|
      wagon_delete = @trains[train_index - 1].wagons[i - 1]
      @trains[train_index - 1].delete_wagon(wagon_delete)
    end
  end

  def move_train_to_station
    show_trains
    puts "Введите номер поезда"
    train_index = gets.chomp.to_i
    loop do
      puts "Поезд стоит на станции #{@trains[train_index - 1].stantion.name}"
      puts "Введите 0 для выхода"
      puts "Введите 1 для перемещения поезда на следующую станцию"
      puts "Введите 2 для перемещения поезда на предыдущую станцию"
      move = gets.chomp.to_i
      case move
      when 0
        break
      when 1
        @trains[train_index - 1].next_station
      when 2
        @trains[train_index - 1].previous_station
      else
        puts "input no correct"
      end
    end
  end
end

