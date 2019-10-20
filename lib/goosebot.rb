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
require 'goosebot/advice_client'
require 'goosebot/goose'

module Goosebot
  class Error < StandardError; end

  class Bot
    include GiphyClient
    include AdviceClient

    attr_reader :bot

    def initialize
      @bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])
    end

    def run
      bot.message(content: '!gooseme') do |event|
        message = <<~DOC
          goosebot v#{VERSION}
          Usage:
          !gooseme gif:\t\tNick's favorite gifs
          !gooseme advice: Advice straight from Nick's heart.
        DOC

        event.respond(message)
      end

      bot.message(content: '!gooseme gif') do |event|
        event.respond(random_gif(options: { tag: Goose.random_tag }).data.url)
      end

      bot.message(content: '!gooseme advice') do |event|
        advice = give_advice
        event.respond("🙏 #{advice} 🙏") unless advice.nil?
      end

      # TODO: underlords stats
      # https://steamdb.info/app/1046930/
      # https://www.openunderlords.com/en/
      # bot.message(content: '!gooseme stats') do |event|
      # end

      bot.message(from: %w[Goose GooseBot]) do |event|
        event.message.react(bot.emoji.sample.to_reaction)
      end

      bot.run
    end
  end
end
