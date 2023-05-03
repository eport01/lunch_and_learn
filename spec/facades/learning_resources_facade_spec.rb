require 'rails_helper' 

RSpec.describe LearningResourcesFacade do 
  it 'creates learning resource objects from image facade and video facade' do
    resource = LearningResourcesFacade.resources("Laos")
    expect(resource).to be_an_instance_of LearningResource
  end
end