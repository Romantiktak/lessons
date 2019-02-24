class PassengerTrain < Train
  protected

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.class == PassengerWagon
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end
end
