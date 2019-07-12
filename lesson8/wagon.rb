class Wagon
  include BrandName
  include Validation

  def initialize(company)
    self.company = company
    validate!
  end

  protected

  def validate!
    raise "Компания не может быть пустой строкой" if self.company.length.zero?
  end
end

