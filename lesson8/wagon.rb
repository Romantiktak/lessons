class Wagon
  include BrandName
  include Validation
  def initialize(company)
    self.company = company
    validate!
  end

  protected
  def validate!
    raise "Company can't be empty" if self.company.length.zero?
  end
end

