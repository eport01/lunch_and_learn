require 'rails_helper' 

RSpec.describe VideoService do 
  describe 'returns a video for a country' do 
    it 'with certain attributs' do 
      videos = VideoService.country_resources("Laos")
      expect(videos).to be_a Hash 

      video = videos[:items][0]

      expect(video).to have_key(:id)
      expect(video[:id]).to have_key(:videoId)

      expect(video[:id][:videoId]).to eq("uw8hjVqxMXw")

      expect(video[:snippet]).to have_key(:title)
      expect(video[:snippet][:title]).to eq("A Super Quick History of Laos")

    end
  end
end