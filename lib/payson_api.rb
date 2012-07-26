required_files = [
  'config',
  'error_codes',
  'client',
  'envelope',
  'funding',
  'order_item',
  'payment_details',
  'payment_update',
  'payment',
  'receiver',
  'remote_error',
  'response/payment_details',
  'response/payment_update',
  'response/payment',
  'sender',
  'shipping_address',
  'version'
]

required_files.each do |file|
  require "payson_api/#{file}"
end
