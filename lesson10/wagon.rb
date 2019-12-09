# frozen_string_literal: true

class Wagon
  include BrandName
  include Validation

  validate :presence, :company

  def initialize(options = {})
    self.company = options[:company] || 'Unknown'
    validate!
  end
end
