require 'uri'

module Tmdb
  class Client
    BASE_URL = 'https://api.themoviedb.org'
    VERSION = 3

    def movie(id)
      uri = movie_url(id)
      puts "URL is #{uri}"
      response = authorized.get(uri)
      puts response.body.to_s
    end

    private

    def authorized
      HTTP.auth("Bearer #{Tmdb.configuration.api_token}")
    end

    def movie_url(id)
      URI.join(BASE_URL, "/#{VERSION}/", "movie/#{id}").to_s
    end
  end
end
