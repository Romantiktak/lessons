class PassengerTrain < Train
  attr_reader :type
  def initialize(number_train, company)
    super
    @type = PassengerWagon
  end
end
