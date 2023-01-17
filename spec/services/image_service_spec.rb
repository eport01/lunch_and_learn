require 'rails_helper' 

RSpec.describe ImageService do 
  describe 'returns a images for a country', :vcr do 
    it 'with certain attributs' do 
      images = ImageService.country_images("Laos")

      expect(images).to be_a Hash 
      expect(images[:results].count).to be <= 10

      image = images[:results][0]

      expect(image).to have_key(:id)
      expect(image[:id]).to be_a String 

      expect(image).to have_key(:alt_description)
      expect(image[:alt_description]).to be_a String 

      expect(image).to have_key(:urls)
      expect(image[:urls]).to be_a Hash     


      expect(image[:urls]).to have_key(:raw)
      expect(image[:urls][:raw]).to be_a String 
    end
  end
end