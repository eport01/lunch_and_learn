require 'rails_helper'

RSpec.describe 'User Registration' do 
  describe 'a visitor can register' do 
    it 'by entering name, email, and password, api key is created and post request is sent to users table', :vcr do 
      user = {
        "name": "Emily Port",
        "email": "emily@mod3_is_almost_complete.com", 
        "password": "1234"
      }
      expect(user[:api_key]).to eq(nil)

      post "/api/v1/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user)

      saved_user = User.last

      expect(saved_user.name).to eq("Emily Port")
      expect(saved_user.email).to eq("emily@mod3_is_almost_complete.com")
      expect(saved_user.password_digest).to_not eq(nil)
      expect(saved_user.api_key).to_not eq(nil) 
    end
    it 'successful post request renders message and status 201', :vcr do 
      user = {
        "name": "Emily Port",
        "email": "emi@mod3_is_almost_complete.com", 
        "password": "1234"
      }

      post "/api/v1/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user)
      
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status 201
      expect(user_response[:data]).to have_key(:id)
      expect(user_response[:data][:type]).to eq("user")

      expect(user_response[:data][:attributes]).to have_key(:name)
      expect(user_response[:data][:attributes][:name]).to be_a String 

      expect(user_response[:data][:attributes]).to have_key(:email)
      expect(user_response[:data][:attributes][:email]).to be_a String 

      expect(user_response[:data][:attributes]).to have_key(:api_key)
      expect(user_response[:data][:attributes][:api_key]).to be_a String 
    end

    it 'user gets error message and status 404 if trying to create user who already exists', :vcr do 
      user1 = {
        "name": "Emily Port",
        "email": "em@mod3_is_almost_complete.com", 
        "password": "1234"
      }
      user2 = {
        "name": "Emily Port",
        "email": "em@mod3_is_almost_complete.com", 
        "password": "1234"
      }
      post "/api/v1/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user1)

      post "/api/v1/users", headers: {'CONTENT_TYPE' => 'application/json'}, params: JSON.generate(user2)
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status 404
      expect(user_response[:error]).to eq("This user already exists, please login")
    end

  end
end