require 'httparty'

class OmdbService
  BASE_URL = 'http://www.omdbapi.com/'
  API_KEY = ENV['OMDB_API_KEY']

  include HTTParty
  base_uri BASE_URL
  default_params apikey: API_KEY
  format :json

  def self.search_movies(title)
    response = get('/', query: { s: title })
    response.parsed_response['Search'] || []
  end

  def self.get_movie_details(imdb_id)
    response = get('/', query: { i: imdb_id })
    response.parsed_response
  end
end
