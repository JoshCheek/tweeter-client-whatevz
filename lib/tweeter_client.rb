require 'faraday'
require 'json'

module TweeterClient
  def self.connection
    @connection ||= Faraday.new(:url => 'http://localhost:3000') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  class Poster
    def self.create(attributes)
      response = TweeterClient.connection.post '/posters', poster: attributes
      actual_attributes = JSON.parse response.body
      new id:   actual_attributes['id'],
          name: actual_attributes['name']
    end

    attr_accessor :id, :name
    def initialize(attrs)
      @id   = attrs[:id]
      @name = attrs[:name]
    end
  end
end
