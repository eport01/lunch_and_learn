class VideoService 
  def self.conn 
    Faraday.new(url: "https://www.googleapis.com/youtube/v3/search") do |faraday|
      faraday.params["key"] = ENV["youtube_api_key"]
      faraday.params["part"] = "snippet"
      faraday.params["channelId"] = "UCluQ5yInbeAkkeCndNnUhpw"
      faraday.params["maxResults"] = 1

    end
  end

  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def self.country_resources(country)
    get_url("?q=#{country}")
  end
end