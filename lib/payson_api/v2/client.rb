require 'net/https'
require 'json'

module PaysonAPI
  module V2
    class Client
      def self.get_account
        response = payson_request(Net::HTTP::Get, PAYSON_API_RESOURCES[:accounts][:get])
        PaysonAPI::V2::Models::Account.from_json(JSON.parse(response.body))
      end

      def self.get_checkout(id)
        response = payson_request(Net::HTTP::Get, PAYSON_API_RESOURCES[:checkouts][:get] % id)
        PaysonAPI::V2::Models::Checkout.from_json(JSON.parse(response.body))
      end

      def self.create_checkout(request)
        response = payson_request(Net::HTTP::Post, PAYSON_API_RESOURCES[:checkouts][:create], request)
        PaysonAPI::V2::Models::Checkout.from_json(JSON.parse(response.body))
      end

      def self.update_checkout(id, request)
        response = payson_request(Net::HTTP::Put, PAYSON_API_RESOURCES[:checkouts][:update] % id, request)
        PaysonAPI::V2::Models::Checkout.from_json(JSON.parse(response.body))
      end

      def self.list_checkouts(request)
        path = [PAYSON_API_RESOURCES[:checkouts][:list], hash_to_params(request.to_hash)].join('?')
        response = payson_request(Net::HTTP::Get, path)
        [].tap do |checkouts|
          JSON.parse(response.body)['data'].each do |json|
            checkouts << PaysonAPI::V2::Models::Checkout.from_json(json)
          end
        end
      end

    private

      def self.hash_to_params(hash)
        hash.map { |k, v| "#{k}=#{URI.encode_www_form_component(v.to_s)}" }.join('&')
      end

      def self.payson_request(method, resource, request = nil)
        url = [PaysonAPI::V2.api_base_url, PAYSON_API_VERSION, resource].join('/')
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        # http.set_debug_output($stdout)
        req = method.new(uri.request_uri)
        req.basic_auth PaysonAPI::V2.config.api_user_id, PaysonAPI::V2.config.api_password
        req.body = request.to_hash.to_json if request
        req['Content-Type'] = 'application/json'
        http.request(req)
      end
    end
  end
end
