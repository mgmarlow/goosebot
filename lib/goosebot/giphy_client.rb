# frozen_string_literal: true

module Goosebot
  class GiphyClient
    attr_accessor :client, :api_key

    FOODS = %w[
      burrito
      taco
      pizza
      doughnut
    ].freeze

    MISC = %w[
      butts
      bouldering
      yoga
    ].freeze

    def initialize
      @client  = ::GiphyClient::DefaultApi.new
      @api_key = ENV['GIPHY_API_KEY']
    end

    def call
      gifs = client.gifs_search_get(api_key, tag, search_options).data
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

    def tag
      items = [].concat(FOODS).concat(MISC)
      items[rand(items.count)]
    end
  end
end
