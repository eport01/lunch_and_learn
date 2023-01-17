class LearningResource
  attr_reader :images, :video, :country 
  def initialize(country, video, images)
    @images = images 
    @video = video
    @country = country 
  end
end