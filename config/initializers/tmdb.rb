require 'tmdb/tmdb'

Tmdb.configure do |config|
  config.api_token = ENV.fetch('TMDB_API_TOKEN')
end
