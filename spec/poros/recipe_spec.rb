require 'rails_helper'

RSpec.describe Recipe, type: :poros do 
  describe 'it returns recipe objects' do 
    it 'response has defined attributes' do 
      recipes = RecipesFacade.recipes("Thailand")
      expect(recipes).to be_an Array 
      recipe = recipes.first 


      expect(recipe).to be_an_instance_of Recipe
      expect(recipe.country).to be_a String 
      expect(recipe.title).to be_a String 
      expect(recipe.url).to be_a String 
    end
  end
end