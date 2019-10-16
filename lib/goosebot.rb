# frozen_string_literal: true

require 'dotenv/load'
require 'discordrb'
require 'GiphyClient'

require 'goosebot/version'
require 'goosebot/bot_client'
require 'goosebot/giphy_client'
require 'goosebot/goose'

module Goosebot
  class Error < StandardError; end

  class Bot
    include GiphyClient
    include BotClient

    def run
      bot_client.message(content: '!gooseme') do |event|
        gif = random_gif(options: {
                           tag: Goose.random_tag
                         })
        event.respond(gif.data.url)
      end

      bot_client.message(from: 'Goose') do |event|
        event.message.react(bot_client.emoji.sample.to_reaction)
      end

      bot_client.run
    end
  end
end
