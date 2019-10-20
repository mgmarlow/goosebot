# frozen_string_literal: true

require 'net/http'
require 'json'
require 'dotenv/load'
require 'discordrb'
require 'GiphyClient'
require 'redd'

require 'goosebot/version'
require 'goosebot/request'
require 'goosebot/giphy_client'
require 'goosebot/reddit_client'
require 'goosebot/advice_client'
require 'goosebot/goose'

module Goosebot
  class Error < StandardError; end

  class Bot
    include GiphyClient
    include RedditClient
    include AdviceClient

    attr_reader :bot

    def initialize
      @bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])
    end

    def run
      bot.message(content: '!gooseme') do |event|
        event.respond(random_message)
      end

      bot.message(from: %w[Goose GooseBot]) do |event|
        event.message.react(bot.emoji.sample.to_reaction)
      end

      bot.run
    end

    def random_message
      case rand(100)
      when 0..70
        random_gif(options: { tag: Goose.random_tag }).data.url
      else
        advice = give_advice
        return if advice.nil?

        "🙏 #{advice} 🙏"
      end

      # TODO: Why does reddit fail on the server?
      # hot_posts(Goose.random_subreddit).sample.url
    end
  end
end
