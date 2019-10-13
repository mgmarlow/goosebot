module Goosebot
  class GiphyClient
    attr_accessor :client, :api_key

    FOODS = %w[
      burrito
      taco
      pizza
      doughnut
      grapefruit
      melons
      'taco bell'
    ]

    MISC = %w[
      'athletic butt'
      butts
      blonde
      'female gymnast'
    ]

    def initialize
      @client  = ::GiphyClient::DefaultApi.new
      @api_key = ENV['GIPHY_API_KEY']
    end

    def call
      client.gifs_search_get(api_key, get_tag, search_options)
    end

    private

    def search_options
      {
        rating: 'r',
        lang: 'en'
      }
    end

    def get_tag
      items = FOODS.concat(MISC)
      items[rand(items.count)]
    end
  end
end
