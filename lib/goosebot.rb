require 'dotenv/load'
require 'discordrb'
require 'GiphyClient'

require 'goosebot/version'
require 'goosebot/bot_client'
require 'goosebot/giphy_client'

module Goosebot
  class Error < StandardError; end
end
