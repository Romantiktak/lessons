class PassengerTrain < Train
  attr_reader :type
  def initialize(number_train, options = {})
    super
    @type = PassengerWagon
  end
end
