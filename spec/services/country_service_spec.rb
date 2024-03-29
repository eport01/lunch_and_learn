require 'rails_helper' 

RSpec.describe CountryService do 
  it 'it returns a list of all the countries' do 
    countries = CountryService.all_countries
    expect(countries).to be_an Array  

    country = countries[0]
    expect(country).to have_key(:name)
    expect(country[:name]).to be_a Hash 
    
    expect(country[:name]).to have_key(:common)
    expect(country[:name][:common]).to eq("Faroe Islands")

    expect(country[:name][:common]).to_not eq("France")

  end

  it 'returns one country' do 
    country = CountryService.find_country("France")
    expect(country).to be_an Array  
    expect(country.count).to eq(1)
    expect(country[0]).to have_key(:name)
    expect(country[0][:name]).to be_a Hash 
    
    expect(country[0][:name]).to have_key(:common)
    expect(country[0][:name][:common]).to eq("France")
    expect(country[0][:name][:common]).to_not eq("Grenada")
  end

  it 'returns status 404 and not found if country is invalid' do 
    country = CountryService.find_country("dog")
    expect(country[:status]).to eq(404)
    expect(country[:message]).to eq("Not Found")
  end

end