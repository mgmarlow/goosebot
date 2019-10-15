# frozen_string_literal: true

module Goosebot
  module BotClient
    def bot_client
      @bot_client ||= Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])
    end
  end
end
