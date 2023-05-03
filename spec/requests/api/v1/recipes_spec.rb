require 'rails_helper'

RSpec.describe 'return recipes for a country', :vcr do 
  before :each do 
    user = {
      "name": "Emily Port",
      "email": "emily@mod3_is_almost_complete.com", 
      "password": "1234"
    }
    expect(user[:api_key]).to eq(nil)

    post "/api/v1/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user)

    @saved_user = User.last
  end
  it 'returns recipes when a user inputs a recipe as params' do 
    country = "Peru"
    get "/api/v1/recipes?country=#{country}&api_key=#{@saved_user.api_key}"
    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)[:data]

    
    expect(recipes[0]).to have_key(:id)
    expect(recipes[0][:id]).to eq(nil)


    expect(recipes[0][:attributes]).to have_key(:title)
    expect(recipes[0][:attributes][:title]).to be_a(String)

    expect(recipes[0][:attributes]).to have_key(:url)
    expect(recipes[0][:attributes][:url]).to be_a(String)

    expect(recipes[0][:attributes]).to have_key(:image)
    expect(recipes[0][:attributes][:image]).to be_a(String)

    expect(recipes[0][:attributes]).to have_key(:country)
    expect(recipes[0][:attributes][:country]).to eq("Peru")

  end


  it 'returns recipes for a random country when no country was input' do 

    get "/api/v1/recipes?country=&api_key=#{@saved_user.api_key}"
    
    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)[:data]

    if recipes != [] 
      expect(recipes[0]).to have_key(:id)
      expect(recipes[0][:id]).to eq(nil)

      expect(recipes[0][:attributes]).to have_key(:title)
      expect(recipes[0][:attributes][:title]).to be_a(String)

      expect(recipes[0][:attributes]).to have_key(:url)
      expect(recipes[0][:attributes][:url]).to be_a(String)

      expect(recipes[0][:attributes]).to have_key(:image)
      expect(recipes[0][:attributes][:image]).to be_a(String)

      expect(recipes[0][:attributes]).to have_key(:country)
      expect(recipes[0][:attributes][:country]).to be_a(String)
    else 
      expect(recipes).to eq([])
    end
    VCR.eject_cassette
  end

  it 'returns an empty array if country entered is invalid or no recipes exist' do 
    get "/api/v1/recipes?country=dog&api_key=#{@saved_user.api_key}"

    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(recipes).to eq([])
  end
end