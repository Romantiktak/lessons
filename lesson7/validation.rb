module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include,  InstanceMethods
  end

  module ClassMethods
    #
  end

  module InstanceMethods
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
end
