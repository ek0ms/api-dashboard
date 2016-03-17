require "net/http"
require "json"
class Events
  attr_reader :state, :city, :events

  def initialize(geolocation)
    @state = geolocation.region_code
    @city = geolocation.city
    @events = get_events
  end

  def uri
    uri = URI("https://api.seatgeek.com/2/events?venue.state=#{@state}&venue.city=#{@city}")
  end

  def get_events
    response = Net::HTTP.get_response(uri)
    summary = JSON.parse(response.body)
    # binding.pry
    @events = []
    summary["events"].each do |event|
      @events << "#{event["title"]} at Venue: #{event["venue"]["name"]} Time: #{event["datetime_local"]}"
    end
    @events
  end
end
