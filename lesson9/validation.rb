# frozen_string_literal: true

# Check exeption
module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def valid_zero(number)
    raise 'Ты не можешь вставить нулевое значение' if number.zero?
  end
end
