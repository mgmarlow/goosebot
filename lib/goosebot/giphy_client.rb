module Goosebot
  class GiphyClient
    attr_accessor :client, :api_key

    FOODS = [
      'burrito',
      'taco',
      'pizza',
      'doughnut',
      'grapefruit',
      'melons',
      'taco bell'
    ]

    MISC = [
      'athletic butt',
      'butts'
    ]

    def initialize
      @client  = ::GiphyClient::DefaultApi.new
      @api_key = ENV['GIPHY_API_KEY']
    end

    def call
      gifs = client.gifs_search_get(api_key, get_tag, search_options).data
      gifs[rand(gifs.count)]
    end

    private

    def search_options
      {
        rating: 'r',
        limit: 100,
        lang: 'en'
      }
    end

    def get_tag
      items = FOODS.concat(MISC)
      items[rand(items.count)]
    end
  end
end
