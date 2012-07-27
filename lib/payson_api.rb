required_files = [
  'config',
  'error_codes',
  'client',
  'envelope',
  'funding',
  'order_item',
  'receiver',
  'remote_error',
  'request/ipn',
  'request/payment_details',
  'request/payment_update',
  'request/payment',
  'response/ipn',
  'response/payment_details',
  'response/payment_update',
  'response/payment',
  'response/validate',
  'sender',
  'shipping_address',
  'version'
]

required_files.each do |file|
  require "payson_api/#{file}"
end
