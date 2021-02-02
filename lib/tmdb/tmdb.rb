require 'tmdb/configuration'
require 'tmdb/client'

module Tmdb
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
