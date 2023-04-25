class CountryFacade 
  def self.random_country 
    CountryService.all_countries.map do |country|
      Country.new(country)
    end
  end

  def self.select_country(country)
    # info = CountryService.find_country(country)[0]
    # Country.new(info) unless info == nil 
    country_cache = Rails.cache.read(['country_name'])
    if country_cache == nil 
      country_cache = CountryService.find_country(country)[0]
      Rails.cache.write(['country_name'], country_cache, expires_in: 5.minutes)
      Country.new(country_cache) 
    else
      Country.new(country_cache) 
    end

  end
end