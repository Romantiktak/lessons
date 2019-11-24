# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_reader :free_seats, :occupied_seats

  def initialize(options = {})
    super
    @seats = @free_seats = options[:free_seats] || 0
    @occupied_seats = options[:occupied_seats] || 0
  end

  def buy_seat(places)
    @free_seats -= places if @free_seats.positive?
  end
end
