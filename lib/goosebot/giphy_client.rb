module Goosebot
  class GiphyClient
    attr_accessor :client, :api_key

    def initialize
      @client  = ::GiphyClient::DefaultApi.new
      @api_key = ENV['GIPHY_API_KEY']
    end

    def call
      client.gifs_random_get(api_key, search_options)
    end

    private

    def search_options
      {
        tag: get_tag,
        rating: 'r',
        lang: 'en'
      }
    end

    def get_tag
      if rand(2) == 0 then 'food' else 'hot girl' end
    end
  end
end
