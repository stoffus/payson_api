require_relative 'payson_api/version'

required_files_v1 = %w[
  config
  client
  envelope
  funding
  order_item
  receiver
  remote_error
  request/ipn
  request/payment_details
  request/payment_update
  request/payment
  response/ipn
  response/payment_details
  response/payment_update
  response/payment
  response/validate
  sender
  shipping_address
]

required_files_v2 = %w[
  config
  client
  models/account
  models/checkout
  models/customer
  models/merchant
  models/order_item
  models/order
  request/order_item
  request/customer
  request/merchant
  request/order
  request/create_checkout
  request/update_checkout
  request/list_checkouts
]

required_files_v1.each do |file|
  require_relative "payson_api/v1/#{file}"
end

required_files_v2.each do |file|
  require_relative "payson_api/v2/#{file}"
end
