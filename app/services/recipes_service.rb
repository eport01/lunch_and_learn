class RecipesService 
  def self.conn 
    Faraday.new(url: "https://api.edamam.com") do |faraday|
      faraday.params["app_id"] = ENV["recipes_app_id"]
      faraday.params["app_key"] = ENV["recipes_app_key"]

    end
  end

  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def self.recipes_for_country(country)
    get_url("/api/recipes/v2?type=public&q=#{country}")
  end
end