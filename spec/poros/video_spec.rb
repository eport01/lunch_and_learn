require 'rails_helper'

RSpec.describe Video, type: :poros do 
  describe 'it returns video objects' do 
    it 'response has defined attributes' do 
      video = VideoFacade.country_videos("Laos")
      
      expect(video).to be_an_instance_of Video 
      expect(video.title).to be_a String 
      expect(video.youtube_video_id).to be_a String 

    end
  end
end