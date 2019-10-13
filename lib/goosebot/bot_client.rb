# frozen_string_literal: true

module Goosebot
  class BotClient
    attr_accessor :bot

    def initialize
      @bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])
    end

    def run
      configure_commands
      bot.run
    end

    private

    def configure_commands
      bot.message(content: '!gooseme') do |event|
        giphy_url = GiphyClient.new.call.bitly_url
        event.respond giphy_url
      end
    end
  end
end
