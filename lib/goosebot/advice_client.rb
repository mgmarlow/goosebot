# frozen_string_literal: true

module Goosebot
  module AdviceClient
    def give_advice
      slip_response = Request.get('https://api.adviceslip.com/advice')
      return if slip_response.nil?

      slip_response.dig('slip', 'advice')
    end
  end
end
