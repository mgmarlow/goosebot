module Goosebot
  module AdviceClient
    def give_advice
      slip_response = Request.get('https://api.adviceslip.com/advice')
      slip_response.dig('slip', 'advice')
    end
  end
end
