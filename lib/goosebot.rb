# frozen_string_literal: true

require 'net/http'
require 'json'
require 'dotenv/load'
require 'discordrb'
require 'GiphyClient'
require 'redd'

require 'goosebot/version'
require 'goosebot/request'
require 'goosebot/bot_client'
require 'goosebot/giphy_client'
require 'goosebot/reddit_client'
require 'goosebot/advice_client'
require 'goosebot/goose'

module Goosebot
  class Error < StandardError; end

  class Bot
    include GiphyClient
    include RedditClient
    include BotClient
    include AdviceClient

    def run
      bot_client.message(content: '!gooseme') do |event|
        event.respond(random_message)
      end

      bot_client.message(from: %w[Goose GooseBot]) do |event|
        event.message.react(bot_client.emoji.sample.to_reaction)
      end

      bot_client.run
    end

    def random_message
      case rand(100)
      when 0..70
        random_gif(options: { tag: Goose.random_tag }).data.url
      else
        advice = give_advice
        "🙏 #{advice} 🙏"
      end

      # TODO: Why does reddit fail on the server?
      # hot_posts(Goose.random_subreddit).sample.url
    end
  end
end
