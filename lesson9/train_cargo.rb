# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type
  def initialize(number_train, options = {})
    super
    @type = CargoWagon
  end
end
