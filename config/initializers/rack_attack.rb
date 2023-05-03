class Rack::Attack 
  Rack::Attack.cache.store = Rails.cache 

  if Time.now.wday.between?(1,5) 
    Rack::Attack.throttle("api_key:weekday-limit", limit: 2, period: 30.seconds) do |req|
      if req.path.include?('/recipes') && req.get?
        req.params["api_key"] 
      end
    end
  else
    Rack::Attack.throttle("api_key:weekend-limit", limit: 5, period: 30.seconds) do |req|
      if req.path.include?('/recipes') && req.get?
        req.params["api_key"] 
      end
    end
  end 
end