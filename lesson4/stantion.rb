class Stantion
  attr_reader :trains
  attr_accessor :name

  def initialize(name)
    @name = name
    @trains = []
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
end
