require 'rails_helper'

RSpec.describe LearningResource, type: :poros do 
  describe 'it returns learning resource objects', :vcr do 
    it 'response has defined attributes' do 
      country_resources = LearningResourcesFacade.resources("Laos")
      expect(country_resources).to be_an_instance_of(LearningResource)

    end
  end
end