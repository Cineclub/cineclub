module Tmdb
  class MovieCreditEntry
    attr_reader :id, :name, :job

    def initialize(data = {})
      @id = data['id']
      @name = data['name']
      @job = data['job']
    end
  end
end
