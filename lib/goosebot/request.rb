module Goosebot
  class Request
    class << self
      def get(url, headers: {})
        uri = URI(url)
        req = Net::HTTP::Get.new(uri)

        headers.each do |k, v|
          req[k] = v
        end

        resp = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end

        case resp
        when Net::HTTPSuccess then
          JSON.parse(resp.body)
        end      
      end
    end
  end
end
