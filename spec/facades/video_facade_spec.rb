require 'rails_helper' 

RSpec.describe VideoFacade do 
  it 'creates a video object for videos based on a country', :vcr do 
    video = VideoFacade.country_videos("Laos")
    expect(video).to be_an_instance_of Video  

    expect(video.title).to eq("A Super Quick History of Laos")
    expect(video.youtube_video_id).to eq("uw8hjVqxMXw")
  end
end