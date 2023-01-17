require 'rails_helper'

RSpec.describe 'User can favorite recipes' do 
  describe 'a visitor can save a recipe to their favorites' do

    it 'and post request returns success message and 201 status', :vcr do 
      user = User.create!({
        "name": "Em",
        "email": "eldo@coolkids.com", 
        "password": "1234", 
        "api_key": "697a91baaff5a683a6c8e8e13d1b928c"
      })

      favorite = {
        "api_key": "697a91baaff5a683a6c8e8e13d1b928c",
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }

      post "/api/v1/favorites", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(favorite)

      favorite_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status 201

      expect(favorite_response[:success]).to eq("Favorite added successfully")


    end
  end
end