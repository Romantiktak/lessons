class CargoTrain < Train
  attr_reader :type
  def initialize(number_train, company)
    super
    @type = CargoWagon
  end
end
