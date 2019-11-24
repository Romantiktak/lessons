# frozen_string_literal: true

class Wagon
  include BrandName
  include Validation

  def initialize(options = {})
    self.company = options[:company] || 'Unknown'
    validate!
  end

  protected

  def validate!
    raise 'Компания не может быть пустой строкой' if company.length.zero?
  end
end
