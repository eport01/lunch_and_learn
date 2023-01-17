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
  end
end