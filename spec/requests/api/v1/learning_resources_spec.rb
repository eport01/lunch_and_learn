require 'rails_helper'

RSpec.describe 'return learning resources for a country' do 
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
  it 'returns images and a video for a country' do
    country = "laos"
    get "/api/v1/learning_resources?country=#{country}&api_key=#{@saved_user.api_key}"

    expect(response).to be_successful

    resources = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(resources).to have_key(:id)
    expect(resources[:id]).to eq(nil)

    expect(resources[:attributes]).to have_key(:country)
    expect(resources[:attributes][:country]).to be_a(String)

    expect(resources[:attributes]).to have_key(:video)
    expect(resources[:attributes][:video]).to be_a(Hash)

    expect(resources[:attributes]).to have_key(:images)
    expect(resources[:attributes][:images]).to be_an(Array)

    expect(resources[:attributes][:video]).to have_key(:title)
    expect(resources[:attributes][:video][:title]).to be_an(String)

    expect(resources[:attributes][:video]).to have_key(:youtube_video_id)
    expect(resources[:attributes][:video][:youtube_video_id]).to be_an(String)
  

    expect(resources[:attributes][:images][0]).to have_key(:alt_tag)
    expect(resources[:attributes][:images][0][:alt_tag]).to be_an(String)

    expect(resources[:attributes][:images][0]).to have_key(:url)
    expect(resources[:attributes][:images][0][:url]).to be_an(String)
  end

  it 'if no video or images are found, the video and image keys point to empty object' do 
    country = "stevenlalalala"
    get "/api/v1/learning_resources?country=#{country}&api_key=#{@saved_user.api_key}"

    expect(response).to be_successful

    resources = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(resources).to have_key(:id)
    expect(resources[:id]).to eq(nil)

    expect(resources[:attributes]).to have_key(:country)
    expect(resources[:attributes][:country]).to be_a(String)

    expect(resources[:attributes]).to have_key(:video)
    expect(resources[:attributes][:video]).to be_a(Hash)



    expect(resources[:attributes]).to have_key(:images)
    expect(resources[:attributes][:images]).to be_an(Array)
    expect(resources[:attributes][:images]).to eq([])


    expect(resources[:attributes][:video]).to_not have_key(:title)

    expect(resources[:attributes][:video]).to_not have_key(:youtube_video_id)
  
  end

end