module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include,  InstanceMethods
  end

  module ClassMethods
    attr_reader :instances
    # я не смог attr_writer сделать protected
    attr_writer :instances
  end

  module InstanceMethods
    private
    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
