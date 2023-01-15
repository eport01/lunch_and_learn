require 'rails_helper' 

RSpec.describe CountryService do 
  it 'it returns a list of all the countries', :vcr do 
    countries = CountryService.random_country
    expect(countries).to be_an Array  

    country = countries[0]
    expect(country).to have_key(:name)
    expect(country[:name]).to be_a Hash 
    
    expect(country[:name]).to have_key(:common)
    expect(country[:name][:common]).to eq("Grenada")

    expect(country[:name][:common]).to_not eq("France")

  end
end