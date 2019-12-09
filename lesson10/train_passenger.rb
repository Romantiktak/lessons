# frozen_string_literal: true

class PassengerTrain < Train
  include BrandName
  include InstanceCounter
  include Validation

  attr_reader :type, :company

  validate :presence, :company
  validate :format, :number_train, Train::NUMBER_FORMAT
  validate :type_class, :type, PassengerWagon

  def initialize(number_train, options = {})
    @type = PassengerWagon
    super
  end
end
