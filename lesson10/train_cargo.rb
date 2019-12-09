# frozen_string_literal: true

class CargoTrain < Train
  include BrandName
  include InstanceCounter
  include Validation

  attr_reader :type, :company

  validate :presence, :company
  validate :format, :number_train, Train::NUMBER_FORMAT
  validate :type_class, :type, CargoWagon

  def initialize(number_train, options = {})
    @type = CargoWagon
    super
  end
end
