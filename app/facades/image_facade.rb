class ImageFacade 
  def self.images(country)
    images = ImageService.country_images(country)
    if images[:total] > 0 
      images[:results].map do |data|
        Image.new(data)
      end
    else 
      []
    end
  end
end