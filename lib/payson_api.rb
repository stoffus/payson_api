# frozen_string_literal: true

require_relative 'payson_api/version'

required_files_v1 = %w[
  config
  client
  envelope
  errors/unknown_currency_error
  errors/unknown_fees_payer_error
  errors/unknown_funding_constraint_error
  errors/unknown_guarantee_offering_error
  errors/unknown_locale_error
  errors/unknown_payment_action_error
  funding
  order_item
  receiver
  remote_error
  requests/ipn
  requests/payment_details
  requests/payment_update
  requests/payment
  responses/ipn
  responses/payment_details
  responses/payment_update
  responses/payment
  responses/validate
  sender
  shipping_address
]

required_files_v2 = %w[
  config
  client
  errors/validation_error
  errors/unauthorized_error
  models/account
  models/checkout
  models/customer
  models/merchant
  models/order_item
  models/order
  requests/order_item
  requests/customer
  requests/merchant
  requests/order
  requests/create_checkout
  requests/update_checkout
  requests/list_checkouts
]

required_files_v1.each do |file|
  require_relative "payson_api/v1/#{file}"
end

required_files_v2.each do |file|
  require_relative "payson_api/v2/#{file}"
end
