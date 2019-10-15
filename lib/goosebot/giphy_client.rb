# frozen_string_literal: true

module Goosebot
  module GiphyClient
    def search_gif(query, options: {})
      defaults = {
        limit: 25,
        offset: 0,
        rating: 'r',
        lang: 'en'
      }

      giphy_client.gifs_search_get(
        giphy_api_key,
        query,
        defaults.merge(options)
      )
    rescue ::GiphyClient::ApiError => e
      puts("Exception when calling DefaultApi->gifs_random_get: #{e}")
    end

    def random_gif(options: {})
      defaults = {
        rating: 'r',
        lang: 'en'
      }

      giphy_client.gifs_random_get(
        giphy_api_key,
        defaults.merge(options)
      )
    rescue ::GiphyClient::ApiError => e
      puts("Exception when calling DefaultApi->gifs_random_get: #{e}")
    end

    private

    def giphy_client
      @giphy_client ||= ::GiphyClient::DefaultApi.new
    end

    def giphy_api_key
      ENV['GIPHY_API_KEY']
    end
  end
end
