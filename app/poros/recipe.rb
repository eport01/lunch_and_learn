class Recipe 
  attr_reader :title, :url, :country, :image 
  def initialize(attributes, country)
    @title = attributes[:label]
    @url = attributes[:url]
    @country = country 
    @image = attributes[:image] 
  end
end