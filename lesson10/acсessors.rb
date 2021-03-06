# rubocop: disable Metrics/AbcSize
module Acсessors
  def attr_accessor_with_history(*args)
    hash_history = Hash.new { |hash, key| hash[key] = [] }
    args.each do |name|
      var_name = "@#{name}".to_sym
      hash_history[var_name]
      var_history = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(var_history) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set(var_history, hash_history[var_name].push(value))
      end
    end
  end

  def strong_attr_accessor(attr_name, class_name)
    var_name = "@#{attr_name}".to_sym
    define_method("#{attr_name}=".to_sym) do |value|
      raise "#{value.class} not equal #{class_name}" if value.class != class_name

      instance_variable_set(var_name, value)
    end
    define_method(attr_name) { instance_variable_get(var_name) }
  end
end
