module Tmdb
  class Movie
    attr_reader :id, :original_title, :imdb_id

    def initialize(data = {})
      @id = data['id']
      @original_title = data['original_title']
      @imdb_id = data['imdb_id']
    end
  end
end
