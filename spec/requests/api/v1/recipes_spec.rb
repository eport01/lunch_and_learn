require 'rails_helper'

RSpec.describe 'return recipes for a country' do 
  it 'returns recipes when a user inputs a recipe as params', :vcr do 
    country = "Peru"
    get "/api/v1/recipes?country=#{country}"
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

    get "/api/v1/recipes?country="
    
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
    expect(recipes[0][:attributes][:country]).to be_a(String)
    VCR.eject_cassette
  end

  it 'returns an empty array if country entered is invalid or no recipes exist', :vcr do 
    get "/api/v1/recipes?country=dog"

    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(recipes).to eq([])
  end
end