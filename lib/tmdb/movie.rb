module Tmdb
  class Movie
    attr_reader :id, :original_title, :imdb_id, :release_date

    def initialize(data = {})
      @id = data['id']
      @original_title = data['original_title']
      @imdb_id = data['imdb_id']
      @release_date = data['release_date']
    end
  end
end
