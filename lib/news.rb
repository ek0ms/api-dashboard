
require "net/http"
require "json"
class News
  attr_reader :news

  def initialize
    @news = get_news
   end

  def uri
    uri = URI("http://api.nytimes.com/svc/topstories/v1/home.json?api-key=#{key}")
  end

  def key
    key = ENV["NYTIMES_API_KEY"]
  end

  def get_news
    response = Net::HTTP.get_response(uri)
    summary = JSON.parse(response.body)
    @news = summary["results"]
  end
end
