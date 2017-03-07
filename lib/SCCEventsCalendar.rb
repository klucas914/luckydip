require 'httparty'

class SCCEventsCalendar
  include HTTParty
  API_URL = 'https://data.sunshinecoast.qld.gov.au/resource/adry-tzke.json'
  
  def parks
  response = HTTParty.get(API_URL)
   # TODO more error checking (500 error, etc)
   response.parsed_response
   response[]["name"]
  end

  def self

  end
end