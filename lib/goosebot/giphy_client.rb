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
      client.gifs_random_get(api_key, search_options)
    rescue ::GiphyClient::ApiError => e
      puts("Exception when calling DefaultApi->gifs_random_get: #{e}")
      # "don't worry about it"
    end

    private

    def search_options
      {
        tag: tag,
        rating: 'r',
        lang: 'en'
      }
    end

    def tag
      items = [].concat(FOODS).concat(MISC)
      items[rand(items.count)]
    end
  end
end
