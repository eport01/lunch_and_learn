class CountryService 
  def self.conn 
    Faraday.new(url: "https://restcountries.com")
  end

  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def self.all_countries
    get_url("/v3.1/all")
  end

  def self.find_country(country)
    get_url("/v3.1/name/#{country}")
  end

end