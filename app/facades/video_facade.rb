class VideoFacade 
  def self.country_videos(country)
    video_info = VideoService.country_resources(country)[:items][0]
    Video.new(video_info)
  end
end