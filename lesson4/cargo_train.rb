class CargoTrain < Train
  protected

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.class == CargoWagon
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end
end
