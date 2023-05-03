require 'rails_helper' 

RSpec.describe RecipesFacade do 
  it 'creates an array of objects' do 
    recipes = RecipesFacade.recipes("Thailand")

    expect(recipes).to be_an Array 
    expect(recipes[0]).to be_an_instance_of(Recipe)

    expect(recipes[0].country).to eq("Thailand")
    expect(recipes[0].title).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
    expect(recipes[0].url).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
  end 

  it 'creates an array of objects even if there is one object' do 
    recipes = RecipesFacade.recipes("Papua New Guinea")

    expect(recipes).to be_an_instance_of(Recipe)

    expect(recipes.country).to eq("Papua New Guinea")
    expect(recipes.country).to_not eq("Thailand")

    expect(recipes.title).to eq("Papua New Guinea Baked Sweet Potatoes")
    expect(recipes.url).to eq("http://www.food.com/recipe/papua-new-guinea-baked-sweet-potatoes-457887")
    
  end

  it 'returns an empty array if country has no recipes' do 
    recipes = RecipesFacade.recipes("Equatorial Guinea")

    expect(recipes).to be_an Array 
    expect(recipes[0]).to_not be_an_instance_of(Recipe)

    expect(recipes).to eq([])

    
  end
end