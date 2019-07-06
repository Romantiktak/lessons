module Validation
  def valid?
    validate!
    true # возвращаем true, если метод validate! не выбросил исключение
  rescue
    false # возвращаем false, если было исключение
  end

  def valid_zero(number)
    raise "You can't to inpute zero value" if number.zero?
  end
end
