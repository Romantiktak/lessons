class CargoWagon < Wagon
  attr_reader :occupied_volume, :free_volume

  def initialize(options = {})
    super
    @occupied_volume = options[:occupied_volume] || 0
    @free_volume = options[:free_volume] || 0
  end

  def take_volume(volume)
    if @free_volume > 0
      @free_volume -= volume
      @occupied_volume += volume
    end
  end

end