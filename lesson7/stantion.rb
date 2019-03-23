class Stantion
  include InstanceCounter
  include Validation
  attr_reader :trains
  attr_accessor :name
  @@count_stantions = 0
  def initialize(name)
    @name = name
    @trains = []
    @@count_stantions += 1
    register_instance
    validate!
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
    @@count_stantions
  end

  protected
  def validate!
    raise "Stantion should to has name" if self.name.length.zero?
  end
end
