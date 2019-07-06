class PassengerWagon < Wagon
  attr_reader :free_seats, :occupied_seats
  attr_writer :free_seats
  def initialize(company, seats)
    super(company)
    @seats = seats
    @free_seats = seats
    @occupied_seats = 0
  end

  def buy_seat
    @free_seats -= 1 if @free_seats > 0
    puts "Свободных мест осталось #{@free_seats}"
  end
  private
  def occupied_seats
    @occupied_seats = @seats - @free_seats
    puts "Занятых мест #{@occupy_seats}"
  end
end
