class VideoFacade 
  def self.country_videos(country)
    video_info = VideoService.country_resources(country)
    if video_info[:pageInfo][:totalResults] > 0 
      Video.new(video_info[:items][0])
    else 
      {}
    end
  end
end