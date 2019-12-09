# frozen_string_literal: true
require 'pry-byebug'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    # validate :name, :type, String
    attr_reader :validators

    def validate(type, var_name, attr = nil)
      # presence - value of attr is not (nil & empty string)
      # format - chek out value of attribute on format
      # type - chek out class of attribute

      @validators ||= []
      @validators.push(type_class: type, variable: var_name, attr: attr)
      # binding.pry
    end
  end

  module InstanceMethods
    def validate!
      self.class.validators.each do |validator|
        # binding.pry
        send("valid_#{validator[:type_class]}".to_s, instance_variable_get("@#{validator[:variable]}"), validator[:attr])
      end
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

  def valid_presence(variable, _)
    # binding.pry
    raise 'attribute name is empty' if variable.nil? || variable.length.zero?
  end

  def valid_format(variable, format_regexp)
    # variable  - value of type Regexp
    raise 'format is not right' if variable !~ format_regexp
  end

  def valid_type_class(variable, type_class)
    # variable - variable, type_class - Class
    if variable.class == Array
      variable.each do |var|
        raise "Class #{var.class} isnot equal #{type_class}" if var.class != type_class
      end
    elsif variable != type_class
      raise 'Class is not correct'
    end
  end
end
