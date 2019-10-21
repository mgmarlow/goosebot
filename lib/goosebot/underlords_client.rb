# frozen_string_literal: true

require 'goosebot/underlords/client'

module Goosebot
  module UnderlordsClient
    def underlords_client
      @underlords_client ||= Underlords::Client.new
    end
  end
end
