# frozen_string_literal: true

require 'dotenv/load'
require 'discordrb'
require 'GiphyClient'
require 'redd'

require 'goosebot/version'
require 'goosebot/bot_client'
require 'goosebot/giphy_client'
require 'goosebot/reddit_client'
require 'goosebot/goose'

module Goosebot
  class Error < StandardError; end

  class Bot
    include GiphyClient
    include RedditClient
    include BotClient

    def run
      bot_client.message(content: '!gooseme') do |event|
        response_url = if rand(2) == 1
          hot_posts(Goose::SUBREDDITS.sample).sample.url
        else
          random_gif(options: { tag: Goose::TAGS.sample }).data.url
        end

        event.respond(response_url)
      end

      bot_client.message(from: %w[Goose GooseBot]) do |event|
        event.message.react(bot_client.emoji.sample.to_reaction)
      end

      bot_client.run
    end
  end
end
