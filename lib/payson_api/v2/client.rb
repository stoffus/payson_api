# frozen_string_literal: true

require 'net/https'
require 'json'

module PaysonAPI
  module V2
    class Client
      def self.account_info
        response = payson_request(Net::HTTP::Get, PAYSON_API_RESOURCES[:accounts][:get])
        PaysonAPI::V2::Models::Account.from_hash(JSON.parse(response.body))
      end

      def self.get_checkout(id)
        response = payson_request(Net::HTTP::Get, PAYSON_API_RESOURCES[:checkouts][:get] % id)
        PaysonAPI::V2::Models::Checkout.from_hash(JSON.parse(response.body))
      end

      def self.create_checkout(request)
        response = payson_request(Net::HTTP::Post, PAYSON_API_RESOURCES[:checkouts][:create], request)
        handle_validation_error(response)
        PaysonAPI::V2::Models::Checkout.from_hash(JSON.parse(response.body))
      end

      def self.update_checkout(request)
        response = payson_request(Net::HTTP::Put, PAYSON_API_RESOURCES[:checkouts][:update] % request.id, request)
        handle_validation_error(response)
        PaysonAPI::V2::Models::Checkout.from_hash(JSON.parse(response.body))
      end

      def self.list_checkouts(request)
        path = [PAYSON_API_RESOURCES[:checkouts][:list], hash_to_params(request.to_hash)].join('?')
        response = payson_request(Net::HTTP::Get, path)
        [].tap do |checkouts|
          JSON.parse(response.body)['data'].each do |json|
            checkouts << PaysonAPI::V2::Models::Checkout.from_hash(json)
          end
        end
      end

      def self.handle_validation_error(response)
        if response.code == '400' || response.code == '500' # rubocop:disable Style/GuardClause
          raise PaysonAPI::V2::Errors::ValidationError, errors: JSON.parse(response.body)['errors']
        end
      end

      def self.hash_to_params(hash)
        hash.map { |k, v| "#{k}=#{URI.encode_www_form_component(v.to_s)}" }.join('&')
      end

      def self.payson_request(method, resource, request = nil)
        url = [PaysonAPI::V2.api_base_url, PAYSON_API_VERSION, resource].join('/')
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        req = method.new(uri.request_uri)
        req.basic_auth PaysonAPI::V2.config.api_user_id, PaysonAPI::V2.config.api_password
        req.body = JSON.generate(request.to_hash) unless request.nil?
        req['Content-Type'] = 'application/json'
        response = http.request(req)
        raise PaysonAPI::V2::Errors::UnauthorizedError if response.code == '401'

        response
      end
    end
  end
end
