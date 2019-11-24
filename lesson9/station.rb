class Station
  include InstanceCounter
  include Validation
  attr_reader :trains
  attr_accessor :name

  @@count_stations = 0

  def initialize(options = {})
    @name = options[:name] || 'Unknown'
    @trains = options[:trains] || []
    @@count_stations += 1
    validate!
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def type_train
    passanger = 0
    cargo = 0
    @trains.each do |train|
      passanger += 1 if train.class == PassengerTrain
      cargo += 1 if train.class == CargoTrain
    end
    { PassengerTrain => passanger, CargoTrain => cargo }
  end

  def self.all
    @@count_stations
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise 'Станция должна иметь имя' if name.length.zero?
  end
end
