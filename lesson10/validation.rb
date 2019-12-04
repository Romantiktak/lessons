# frozen_string_literal: true

module Validation

  # Хочу сделать хеш, чтобы проверять названные атррибуты у каждой инстанс переменной класса
  @@var_validate = {'Train' => ['company', '@@trains[self]'.to_s], 'Route' => [], 'Station' => []}

  # type_valid: :presence or :format or :type

  # Возможно лучше в аргкменты def validate массив *arr передавать , я не знаю
  def validate(type_valid, name_attr, check_value = nil)
    # presence - value of attr is not (nil & empty string)
    # format - chek out value of attribute on format
    # type - chek out class of attribute


    send("valid_#{type_valid}".to_s, name_attr, check_value)
  end

  def validate!

    @@var_validate[self.class.to_s].each do |string_attr|
      validate(:presence, string_attr.to_s)
      puts "#{string_attr.to_s} проверяется на presence"
    end

  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def valid_zero(number)
    raise 'Ты не можешь вставить нулевое значение' if number.zero?
  end

# пришлось в valid_presence написать лишний аттрибут check_value , потому что
# в 17й строке в функцию передаю 2 аттррибута, как избавиться от лишней передачи параметров в методе?
  def valid_presence(name_attr, check_value)
    raise 'attribute name is empty' if name_attr.nil? && name_attr.lenght.zero?
  end

  def valid_format(number, format_regexp)
    # check_value  - value of type Regexp
    raise 'format is not right' if number !~ format_regexp.freeze
  end

  def valid_type(attribute, type_class)
    # attribute - variable, type_class - Class
    raise 'Class is not correct' if attribute.class != type_class
  end
end

