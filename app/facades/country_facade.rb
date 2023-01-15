class CountryFacade 
  def self.country 
    CountryService.random_country.map do |country|
      Country.new(country)
    end
  end
end