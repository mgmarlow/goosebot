# frozen_string_literal: true

require 'net/http'
require 'json'
require 'dotenv/load'
require 'discordrb'
require 'GiphyClient'
require 'pry'

require 'goosebot/request'
require 'goosebot/version'
require 'goosebot/underlords_client'
require 'goosebot/giphy_client'
require 'goosebot/advice_client'
require 'goosebot/goose'

module Goosebot
  class Error < StandardError; end

  class Bot
    include GiphyClient
    include AdviceClient
    include UnderlordsClient

    attr_reader :bot

    def initialize
      @bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])
    end

    def run
      bot.message(content: '!gooseme') do |event|
        message = <<~DOC
          v#{VERSION}
          `!gooseme gif`:\t\t\tNick's favorite gifs.
          `!gooseme advice`:\t Advice straight from Nick's heart.
          `!gooseme build`:\t   Build your best underlords comp and share it.

          Call out DOTA underlords heroes with [heroname].
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
      # bot.message(content: '!gooseme stats') do |event|
      # end

      bot.message(containing: /\[(.*?)\]/) do |event|
        event.message.content.scan(/\[(.*?)\]/).each do |hero_name|
          hero_name = hero_name.first.downcase

          if underlords_client.hero_names.include?(hero_name)
            hero = underlords_client.heroes.detect { |h| h.name.downcase == hero_name }
            event.respond(hero.preview)
          end
        end
      end

      bot.message(content: '!gooseme build') do |event|
        event.respond('https://underlords.app/build')
      end

      bot.message(from: %w[Goose GooseBot]) do |event|
        event.message.react(bot.emoji.sample.to_reaction)
      end

      bot.run
    end
  end
end
