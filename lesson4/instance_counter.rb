module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    public
    def instances
      @instance
    end
    private
    def add_instance
      @instance ||= 0
      @instance += 1
    end
  end

  module InstanceMethods
    private
    def register_instance
      self.class.send :add_instance
    end
  end
end
