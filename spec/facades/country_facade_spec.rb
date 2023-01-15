require 'rails_helper' 

RSpec.describe CountryFacade do 
  it 'creates an array of objects', :vcr do 
    countries = CountryFacade.random_country 

    expect(countries).to be_an Array 
    expect(countries[0]).to be_an_instance_of(Country)

    expect(countries[0].name).to eq("Grenada")

  end
end