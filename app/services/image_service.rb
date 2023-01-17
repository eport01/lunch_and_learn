class ImageService 
  def self.conn 
    Faraday.new(url: "https://api.unsplash.com/search/photos/") do |faraday|
      faraday.params[:client_id] = ENV["unsplash_access_key"]
      # faraday.params["client_secret"] = ENV["unsplash_secret_key"]
      # faraday.params["order_by"] = "relevant"
      # faraday.params["per_page"] = 10
      # faraday.params["page"] = 1
    end
  end
  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def self.country_images(country)
    # require 'pry'; binding.pry
    get_url("?query=#{country}")
  end
end