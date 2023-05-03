require 'rails_helper'

RSpec.describe Country, type: :poros do 
  describe 'it returns country objects', :vcr do 
    it 'responses have name attributes' do 
      countries = CountryFacade.random_country
      expect(countries).to be_an Array 
      country = countries.first 
      expect(country).to be_an_instance_of Country
      expect(country.name).to be_a String 
      expect(country.name).to eq("Faroe Islands")
      expect(country.name).to_not eq("France")


    end
  end
end