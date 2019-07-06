class CargoWagon < Wagon
  attr_reader :free_volume, :occupied_seats
  attr_writer :free_volume
  def initialize(company, volume)
    super(company)
    @volume = volume
    @free_volume = volume
  end

  def take_volume
    @free_volume -= 1 if @free_volume > 0
    puts "Свободный объем #{@free_volume}"
  end

  def view_take_volume
    occupied_volume = @volume - @free_volume
    puts "Занятый  объем #{occupied_volume}"
  end

  def view_free_volume
    puts "Свободный  объем #{@free_volume}"
  end

end
