class ImageFacade 
  def self.images(country)
    ImageService.country_images(country)[:results].map do |data|
      Image.new(data)
    end
  end
end