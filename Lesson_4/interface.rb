require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require_relative 'station'
require_relative 'route'
require 'colorize'
require 'cli/ui'

class Interface

  TEXT = {
    input_error: 'Ошибка! Попробуйте еще раз.'.red,
  }
  MAIN_MENU = %w[Станции Поезда Маршруты Выход]
  STATION_MENU = [
    'Создать станцию',
    'Посмотреть список станций',
    'Назад'
  ]
  TRAIN_MENU = [
    'Создать поезд',
    'Назначить маршрут поезду',
    'Добавить вагон к поезду',
    'Отцепить вагон от поезда',
    'Переместить поезд вперед',
    'Переместить поезд назад',
    'Информация о поезде',
    'Назад'
  ]
  ROUTE_MENU = [
    'Создать маршрут',
    'Добавить станцию в марштрут',
    'Удалить станцию из маршрута',
    'Назад'
  ]
  TRAIN_TYPE = %w[Пассажирский Грузовой]

  def run
    initialize_variables
    main_menu
  end

  private

  def get_user_data(type: nil)
    puts yield if block_given?
    case type
    when :name
      gets.chomp.capitalize
    when :train_type
      loop do
        choise = CLI::UI.ask('Тип поезда', options: TRAIN_TYPE)
        case choise
        when TRAIN_TYPE[0]
          return 1
        when TRAIN_TYPE[1]
          return 2
        end
      end
    else
      gets.chomp
    end
  end

  def create_train
    type = get_user_data(type: :train_type) { "Insert type of train:" }

    begin
      number = get_user_data { "Insert number of train:" }
      case type
      when 1
        @trains << PassengerTrain.new(number)
      when 2
        @trains << CargoTrain.new(number)
      end
    rescue RuntimeError => e
      puts e.message
      retry
    end

    puts "Поезд ##{number} создан"
  end

  def set_route
    train = select_train
    route = select_route
    train.get_route(route)
  end

  def create_station
    name = get_user_data(type: :name) { puts 'Введите имя станции:' }
    @stations << Station.new(name)
  end

  def station_menu
    loop do
      choise = CLI::UI.ask('Станции', options: STATION_MENU)
      case choise
      when STATION_MENU[0]
        create_station
      when STATION_MENU[1]
        @stations.each { |station| puts station.name }
      when 'Назад'
        return
      else
        puts 'Ошибка! Пожалуйста повторите ввод'.red
      end
    end
  end

  def add_cargo_to_train
    train = select_train
    train.attach_carriage
    cargo_information(train)
  end

  def unhook_carriage
    train = select_train
    train.unhook_carriage
    cargo_information(train)
  end

  def move_forward
    train = select_train
    return unless train.move_forward
    current_station(train)
  end

  def move_back
    train = select_train
    return unless train.move_back
    current_station(train)
  end

  def cargo_information(train)
    puts "Кол-во вагонов: #{train.carriages.count}".yellow
  end

  def current_station(train)
    puts "Текущая станция: #{train.current_station.name}".yellow
  end

  def train_information
    train = select_train
    puts "Номер поезда: #{train.number}".yellow
    cargo_information(train)
    return unless train.route
    puts "Маршрут: #{train.route.name}"
    current_station(train)
  end

  def check_train?
    puts 'Создайте поезд'.red unless @trains.any?
    @trains.any?
  end

  def train_menu
    loop do
      choise = CLI::UI.ask('Поезда', options: TRAIN_MENU)
      case choise
      when TRAIN_MENU[0]
        create_train
      when TRAIN_MENU[1]
        set_route if check_train?
      when TRAIN_MENU[2]
        add_cargo_to_train if check_train?
      when TRAIN_MENU[3]
        unhook_carriage if check_train?
      when TRAIN_MENU[4]
        move_forward if check_train?
      when TRAIN_MENU[5]
        move_back if check_train?
      when TRAIN_MENU[6]
        train_information if check_train?
      when 'Назад'
        return
      else
        puts 'Ошибка! Пожалуйста повторите ввод'.red
      end
    end
  end

  def create_route
    all_stations_name = get_all_station
    start_station = select_value(all_stations_name, @stations) { 'Начальная станция' }
    all_stations_name.delete(start_station.name)
    end_station = select_value(all_stations_name, @stations) { 'Конечная станция' }
    @routes << Route.new(start_station, end_station)
  end

  def select_route
    routs_hash = {}
    @routes.each_with_index { |route, index| routs_hash.merge!({ route.name => index }) }
    return unless routs_hash.keys.any?
    route = CLI::UI.ask('Выберете маршрут', options: routs_hash.keys)
    route_index = routs_hash[route]
    @routes[route_index]
  end

  def add_station_to_route
    current_route = select_route

    stations_name = get_all_station
    stations_name -= current_route.station_list

    station = select_value(stations_name, @stations) { 'Добавить станцию' }
    current_route.add_intermediate_station(station)
  end

  def delete_station_to_route
    current_route = select_route

    stations_name = current_route.station_list[1..-2]
    return unless stations_name
    station = select_value(stations_name, current_route.stations) { 'Удалить станцию' }
    current_route.delete_intermediate_station(station)
  end

  def route_menu
    loop do
      choise = CLI::UI.ask('Поезда', options: ROUTE_MENU)
      case choise
      when ROUTE_MENU[0]
        create_route
      when ROUTE_MENU[1]
        add_station_to_route
      when ROUTE_MENU[2]
        delete_station_to_route
      when 'Назад'
        return
      else
        puts 'Ошибка! Пожалуйста повторите ввод'.red
      end
    end
  end

  def main_menu
    loop do
      choise = CLI::UI.ask('Главное меню', options: MAIN_MENU)
      case choise
      when MAIN_MENU[0]
        station_menu
      when MAIN_MENU[1]
        train_menu
      when MAIN_MENU[2]
        @stations.count >= 2 ? route_menu : puts('Необходимо создать станции.'.red)
      when 'Выход'
        return
      end
    end
  end

  def get_all_train
    @trains.map { |train| train.number.to_s }
  end

  def get_all_station
    @stations.map { |station| station.name }
  end

  def initialize_variables
    @stations = []
    @trains = []
    @routes = []
  end

  def select_value(name, array)
    return unless name.any?
    choice = CLI::UI.ask(yield, options: name)
    array.find { |i| i.name == choice }
  end

  def select_train
    return unless get_all_train.any?
    choice = CLI::UI.ask('Выберете поезд', options: get_all_train)
    @trains.find { |i| i.number == choice.to_i }
  end
end

