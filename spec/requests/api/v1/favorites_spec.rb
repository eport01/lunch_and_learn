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

    it 'returns error message and status 404 if api key does not find a user', :vcr do 
      favorite = {
        "api_key": "123a91baaff5a683a6c8e8e13d1b928c",
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }

      post "/api/v1/favorites", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(favorite)

      favorite_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status 404
      expect(favorite_response[:error]).to eq("No user with that api key exists")
    end
  end
  describe 'a user can get all of their favorited recipes' do 
    it 'favorites index with api key passed in query params', :vcr do 
      user = User.create!({
        "name": "Em",
        "email": "eldo@coolkids.com", 
        "password": "1234", 
        "api_key": "697a91baaff5a683a6c8e8e13d1b928c"
      })

      user2 = User.create!({
        "name": "Ellie",
        "email": "el@coolkids.com", 
        "password": "1234", 
        "api_key": "123a91baaff5a683a6c8e8e13d1b928c"
      })
      favorite1 = user.favorites.create!({user_id: user.id, 
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", 
        created_at: "2023-01-17T19:10:50.357Z"

      })
      favorite2 = user.favorites.create!({user_id: user.id,
        country: "united states",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "cheeseburger", 
        created_at: "2023-01-17T19:10:50.357Z"
      })

      favorite3 = user2.favorites.create!({ user_id: user.id,
        country: "united states",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "cheeseburger", 
        created_at: "2023-01-17T19:10:50.357Z"
      })

      get "/api/v1/favorites?api_key=697a91baaff5a683a6c8e8e13d1b928c"

      expect(response).to be_successful

      favorites = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(favorites.count).to eq(2)
      expect(favorites[0][:attributes]).to have_key(:recipe_title)
      expect(favorites[0][:attributes][:recipe_title]).to be_a String 

      expect(favorites[0][:attributes]).to have_key(:recipe_link)
      expect(favorites[0][:attributes][:recipe_link]).to be_a String 

      expect(favorites[0][:attributes]).to have_key(:country)
      expect(favorites[0][:attributes][:country]).to be_a String 

      expect(favorites[0][:attributes]).to have_key(:created_at)
      expect(favorites[0][:attributes][:created_at]).to be_a String 
      expect(favorites).to_not include(favorite3)
    end

    it 'a user with no favorited recipes returns an empty array', :vcr do 
      user = User.create!({
        "name": "Em",
        "email": "eldo@coolkids.com", 
        "password": "1234", 
        "api_key": "4eeac766b9a1efcf05df89ca20bd70ef"
      })
      get "/api/v1/favorites?api_key=4eeac766b9a1efcf05df89ca20bd70ef"

      expect(response).to be_successful

      favorites = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(favorites).to eq([])

    end

    it 'an error message is returned if user does not exist', :vcr do 
      get "/api/v1/favorites?api_key=1234766b9a1efcf05df89ca20bd70ef"

      favorites = JSON.parse(response.body, symbolize_names: true)
      expect(favorites[:error]).to eq("No user with that api key exists")
    
      expect(response).to have_http_status 404

    end
  end

  describe 'delete a favorited recipe' do 
    it 'can send delete request with api key and favorite_id to delete saved recipe', :vcr do 
      user = User.create!({
        "name": "Em",
        "email": "eldo@coolkids.com", 
        "password": "1234", 
        "api_key": "697a91baaff5a683a6c8e8e13d1b928c"
      })

      user2 = User.create!({
        "name": "Ellie",
        "email": "el@coolkids.com", 
        "password": "1234", 
        "api_key": "123a91baaff5a683a6c8e8e13d1b928c"
      })
      favorite1 = user.favorites.create!({user_id: user.id, 
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", 
        created_at: "2023-01-17T19:10:50.357Z", 
        id: 12 


      })
      favorite2 = user.favorites.create!({user_id: user.id,
        country: "united states",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "cheeseburger", 
        created_at: "2023-01-17T19:10:50.357Z"
      })

      favorite3 = user2.favorites.create!({ user_id: user.id,
        country: "united states",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "cheeseburger", 
        created_at: "2023-01-17T19:10:50.357Z"
      })

      expect(user.favorites).to include(favorite1, favorite2)
      expect(user.favorites).to_not include(favorite3)
      json_body = {
        api_key: "697a91baaff5a683a6c8e8e13d1b928c",
        favorite_id: 12
      }

      delete "/api/v1/favorites", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(json_body)
    
      deleted_response = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(response).to have_http_status 200

      expect(deleted_response[:message]).to eq("The recipe was successfully deleted from your favorites")

      expect(user.favorites).to include(favorite2)

      expect(user.favorites.where(id: 12)).to eq([])

    end

    it 'returns an error message if no favorites exist for that user', :vcr do 
      user = User.create!({
        "name": "Em",
        "email": "eldo@coolkids.com", 
        "password": "1234", 
        "api_key": "697a91baaff5a683a6c8e8e13d1b928c"
      })

      json_body = {
        api_key: "697a91baaff5a683a6c8e8e13d1b928c",
        favorite_id: 12
      }

      delete "/api/v1/favorites", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(json_body)
    
      deleted_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status 404

      expect(deleted_response[:error]).to eq("No favorite recipe exists with that id")
    end
  end

end