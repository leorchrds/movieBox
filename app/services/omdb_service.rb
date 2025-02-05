require 'net/http'
require 'json'

class OmdbService
  BASE_URL = "http://www.omdbapi.com/"
  API_KEY = ENV['OMDB_API_KEY']

  def self.search_movies(title)
    uri = URI("#{BASE_URL}?apikey=#{API_KEY}&s=#{URI.encode_www_form_component(title)}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)["Search"] || []
  end

  def self.get_movie_details(imdb_id)
    uri = URI("#{BASE_URL}?apikey=#{API_KEY}&i=#{imdb_id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
