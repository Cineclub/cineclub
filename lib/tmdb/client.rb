require 'json'
require 'tmdb/movie'
require 'tmdb/movie_credit_entry'

module Tmdb
  class Client
    BASE_URL = 'https://api.themoviedb.org'.freeze
    API_VERSION = 3

    def initialize(options = {})
      @api_token = options[:api_token] || Tmdb.configuration.api_token
      @base_url = options[:base_url] || BASE_URL
      @api_version = options[:api_version] || API_VERSION
    end

    def movie(id)
      response = authorized.get(movie_url(id))
      data = JSON.parse(response.body)
      Tmdb::Movie.new(data)
    end

    def movie_crew(movie_id)
      response = authorized.get(movie_credits_url(movie_id))
      data = JSON.parse(response.body)
      data['crew'].map { |e| Tmdb::MovieCreditEntry.new(e) }
    end

    private

    def authorized
      @authorized ||= HTTP.auth("Bearer #{@api_token}")
    end

    def movie_url(id)
      "#{versioned_url}/movie/#{id}"
    end

    def movie_credits_url(id)
      "#{movie_url(id)}/credits"
    end

    def versioned_url
      @versioned_url ||= "#{@base_url}/#{@api_version}"
    end
  end
end
