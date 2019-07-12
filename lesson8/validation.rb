module Validation
  def valid?
    validate!
    true # возвращаем true, если метод validate! не выбросил исключение
  rescue
    false # возвращаем false, если было исключение
  end

  def valid_zero(number)
    raise "Ты не можешь вставить нулевое значение" if number.zero?
  end
end
