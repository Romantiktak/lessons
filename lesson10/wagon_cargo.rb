# frozen_string_literal: true

class CargoWagon < Wagon
  include BrandName
  include Validation

  validate :presence, :company
  attr_reader :occupied_volume, :free_volume

  def initialize(options = {})
    super
    @occupied_volume = options[:occupied_volume] || 0
    @free_volume = options[:free_volume] || 0
  end

  def take_volume(volume)
    return unless @free_volume.positive?

    @free_volume -= volume
    @occupied_volume += volume
  end
end
