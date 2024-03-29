require 'rails_helper' 

RSpec.describe VideoFacade do 
  it 'creates a video object for videos based on a country' do 
    video = VideoFacade.country_videos("Laos")
    expect(video).to be_an_instance_of Video  

    expect(video.title).to eq("A Super Quick History of Laos")
    expect(video.youtube_video_id).to eq("uw8hjVqxMXw")
  end

  it 'returns an empty hash if no videos were found' do 
    video = VideoFacade.country_videos("stevenlalalala")

    expect(video).to eq({})
  end
end