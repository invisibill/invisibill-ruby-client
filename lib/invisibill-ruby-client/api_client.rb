require 'typhoeus'

API_SCHEME = ENV['API_SCHEME'] || 'https'
API_HOST = ENV['API_HOST'] || 'api.invisi-bill.com'
API_USER_AGENT = ENV['API_USER_AGENT'] || 'invisibill-ruby-client api'
API_MAX_ATTEMPTS = (ENV['API_MAX_ATTEMPTS'] || 5).to_i

module Invisibill
  class ApiClient
    class << self
      def base_url
        "#{API_SCHEME}://#{API_HOST}"
      end
    end

    def initialize(token)
      @token = token
    end

    def get(uri, params = { })
      send_request(:get, uri, params)
    end

    def post(uri, params = { })
      send_request(:post, uri, params)
    end

    def put(uri, params = { })
      send_request(:put, uri, params)
    end

    def delete(uri, params = { })
      send_request(:delete, uri, params)
    end

    def send_request(method, uri, params)
      attempts = 0

      begin
        params = [:post, :put, :patch].include?(method.to_s.downcase.to_sym) ? { body: JSON.dump(params) } : { params: params }
        headers = api_request_headers
        headers['Content-Type'] = 'application/json' if [:post, :put, :patch].include?(method.to_s.downcase.to_sym)
        params.merge!(headers: headers)
        Typhoeus.send(method.to_s.downcase.to_sym, "#{ApiClient.base_url}/api/#{uri}", params)
      rescue Exception => ex
        attempts = attempts + 1
        retry if attempts < API_MAX_ATTEMPTS
      end
    end

    private

    def api_authorization_header
      "bearer #{@token}"
    end

    def api_request_headers
      {
          'User-Agent'          => API_USER_AGENT,
          'Authorization' => api_authorization_header
      }
    end
  end
end
