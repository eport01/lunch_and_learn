require 'rails_helper' 

RSpec.describe RecipesFacade do 
  it 'creates an array of objects', :vcr do 
    recipes = RecipesFacade.recipes("Thailand")

    expect(recipes).to be_an Array 
    expect(recipes[0]).to be_an_instance_of(Recipe)

    expect(recipes[0].country).to eq("Thailand")
    expect(recipes[0].title).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
    expect(recipes[0].url).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
  end 

  it 'creates an array of objects even if there is one object', :vcr do 
    recipes = RecipesFacade.recipes("Papua New Guinea")
    expect(recipes).to be_an Array 
    expect(recipes[0]).to be_an_instance_of(Recipe)

    expect(recipes[0].country).to eq("Papua New Guinea")
    expect(recipes[0].country).to_not eq("Thailand")

    
  end

  it 'returns an empty array if country has no recipes', :vcr do 
    recipes = RecipesFacade.recipes("Equatorial Guinea")
    expect(recipes).to be_an Array 
    expect(recipes).to eq([])

    
  end
end