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
      puts "#{self} успешно создан"
    rescue
      false # возвращаем false, если было исключение
      puts "Данные не валидны, объект не создан"
    end
  end
end
