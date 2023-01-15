class CountryFacade 
  def self.random_country 
    CountryService.all_countries.map do |country|
      Country.new(country)
    end
  end

  def self.select_country(country)
    info = CountryService.find_country(country)[0]
    Country.new(info) unless info == nil 
  end
end