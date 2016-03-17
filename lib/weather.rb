require "net/http"
require "json"
class Weather
  attr_reader :temperature, :latitude, :longitude

  def initialize(geolocation)
    # fix: geolocation["latitude"]
    @latitude = geolocation.latitude
    @longitude = geolocation.longitude
    #@time = Time.now.split
    @temperature = get_weather
  end

  def uri
    uri = URI("https://api.forecast.io/forecast/#{key}/#{@latitude},#{@longitude}")
  end

  def key
    key = ENV["DARKSKY_API_KEY"]
  end

  def get_weather
    response = Net::HTTP.get_response(uri)
    summary = JSON.parse(response.body)
    @temperature = summary["currently"]["temperature"]
  end
end
