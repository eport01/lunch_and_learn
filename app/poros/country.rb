class Country 
  attr_reader :name 
  def initialize(attributes)
    @name = attributes[:name][:official]
  end
end