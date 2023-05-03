require 'rails_helper'

RSpec.describe Image, type: :poros do 
  describe 'it returns image objects' do 
    it 'response has defined attributes' do 
      images = ImageFacade.images("Laos")
      expect(images). to be_an Array 

      expect(images[0]).to be_an_instance_of Image 
      expect(images[0].alt_tag).to be_a String 
      expect(images[0].url).to be_a String 

    end
  end
end