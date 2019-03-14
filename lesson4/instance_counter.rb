module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance
    @instance = 0
    def instances
      @instance
    end
    def add_instance
      @instance += 1
    end
  end

  module InstanceMethods

    def register_instance
      self.class.add_instance
    end
  end
end
