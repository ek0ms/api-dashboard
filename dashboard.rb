require "./lib/geolocation"
require "sinatra/base"
require "json"
require "net/http"
require "dotenv"
require 'pry'
require './lib/weather'
require './lib/events'
require './lib/news'
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do

    # binding.pry
    @ip = request.ip
    @geolocation = Geolocation.new(@ip)
    erb :dashboard
    #binding.pry
  end

  get("/weather") do
    @geolocation = Geolocation.new(@ip)

    @weather_now = Weather.new(@geolocation)
    # binding.pry
    erb :weather
  end

  get("/events") do
    @geolocation = Geolocation.new(@ip)

    @events_now = Events.new(@geolocation)
    # binding.pry
    erb :events
  end

  get("/news") do

    @news_now = News.new
    # binding.pry
    erb :news
  end

end
