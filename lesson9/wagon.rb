class Wagon
  include BrandName
  include Validation

  def initialize(options = {})
    self.company = options[:company] || 'Unknown'
    validate!
  end

  protected

  def validate!
    raise "Компания не может быть пустой строкой" if self.company.length.zero?
  end
end

