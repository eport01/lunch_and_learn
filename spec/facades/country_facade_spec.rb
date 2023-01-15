require 'rails_helper' 

RSpec.describe CountryFacade do 
  it 'creates an array of objects', :vcr do 
    countries = CountryFacade.random_country 

    expect(countries).to be_an Array 
    expect(countries[0]).to be_an_instance_of(Country)

    expect(countries[0].name).to eq("Grenada")

  end

  it 'creates one country object from input country name if name is valid', :vcr do 
    country = CountryFacade.select_country("Peru")
    expect(country).to be_an_instance_of(Country)
    expect(country.name).to eq("Peru")
    expect(country.name).to_not eq("Grenada")
  end

  it 'returns nil if country doesnt exist', :vcr do 
    country = CountryFacade.select_country("dog")
    expect(country).to eq(nil)
    expect(country).to_not eq("dog")
  end
end