class LearningResourcesFacade 
  def self.resources(country)
    video = VideoFacade.country_videos(country)
    images = ImageFacade.images(country)
    LearningResource.new(country, video, images)
  end
end