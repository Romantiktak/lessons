# frozen_string_literal: true

module Validation
  # type_valid: :presence or :format or :type
  def validate(type_valid, name_attr, check_value = nil)
    # presence - value of attr is not (nil & empty string)
    # format - chek out value of attribute on format
    # type - chek out class of attribute
    if type_valid == :presence
      valid_presence(name_attr)
    elsif type_valid == :format
      valid_format(name_attr, check_value)
    elsif type_valid == :type
      valid_type(name_attr, check_value)
    else
      raise 'type of validation is not correct'
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

  def valid_presence(name_attr)
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
