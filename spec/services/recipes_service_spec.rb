require 'rails_helper' 

RSpec.describe RecipesService do 
  describe 'returns attributes for recipes' do 
    it 'has certain attributes' do 
      recipes = RecipesService.recipes_for_country("thailand")
      expect(recipes).to be_a Hash  

      recipe = recipes[:hits][0][:recipe]

      expect(recipe).to have_key(:label)
      expect(recipe[:label]).to be_a String 

      expect(recipe).to have_key(:image)
      expect(recipe[:image]).to be_a String

      expect(recipe).to have_key(:url)
      expect(recipe[:url]).to be_a String
    end
  end
end