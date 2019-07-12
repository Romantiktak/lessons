class CargoWagon < Wagon
  attr_reader :occupied_volume, :free_volume

  def initialize(company, all_volume)
    super(company)
    @occupied_volume = 0
    @free_volume = all_volume
  end

  def take_volume(volume)
    if @free_volume > 0
      @free_volume -= volume
      @occupied_volume += volume
    end
  end

end
