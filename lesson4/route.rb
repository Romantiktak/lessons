class Route
  attr_reader :stantions

  def initialize(first_stantion, last_stantion)
    @stantions = [first_stantion, last_stantion]
  end

  def add_stantion(stantion)
    @stantions.insert(-2, stantion) unless @stantions.include?(stantion)
  end

  def delete_stantion(name)
    @stantions.delete(name) unless (@stantions.first == name) || (@stantions.last == name)
  end
end
