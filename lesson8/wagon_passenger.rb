class PassengerWagon < Wagon
  attr_reader :free_seats, :occupied_seats

  def initialize(company, seats)
    super(company)
    @seats = seats
    @free_seats = seats
    @occupied_seats = 0
  end

  def buy_seat(places)
    @free_seats -= places if @free_seats > 0
  end

  def occupied_seats
    @occupied_seats = @seats - @free_seats
  end
end
