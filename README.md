# Payson API

A simple utility to handle requests against the Payson payment gateway API.

## Supported Ruby versions

* 2.6
* 2.7
* 3.0

## Install

Put this line in your Gemfile:

    gem 'payson_api'

Then bundle:

    $ bundle

## Usage (v1)

This explains how to use the Payson 1.0 API (https://tech.payson.se/paysoncheckout1). Documentation for the v2 API will be added soon.

### General configuration options

You need to configure the gem with your own Payson credentials through the <tt>PaysonAPI.configure</tt> method:

```ruby
PaysonAPI::V1.configure do |config|
  config.api_user_id = 'XXXX'
  config.api_password = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
end
```

Please note that if `config.api_user_id` is set to 4, the client will go into test mode. Valid test access credentials could be found in {documentation}[https://tech.payson.se/#Testing/sandbox].

For more detailed testing you may create your own test agent for use in the test environment. Use `config.test_mode = true`

### Initiating a payment

```ruby
return_url = 'http://localhost/payson/success'
cancel_url = 'http://localhost/payson/cancel'
ipn_url = 'http://localhost/payson/ipn'
memo = 'Sample order description'

receivers = []
receivers << PaysonAPI::V1::Receiver.new(
  email = 'me@mydomain.com',
  amount = 100,
  first_name = 'Me',
  last_name = 'Just me',
  primary = true
)

sender = PaysonAPI::V1::Sender.new(
  email = 'mycustomer@mydomain.com',
  first_name = 'My',
  last_name = 'Customer'
)

order_items = []
order_items << PaysonAPI::V1::OrderItem.new(
  description = 'Order item description',
  unit_price = 100,
  quantity = 1,
  tax = 0,
  sku = 'MY-ITEM-1'
)

payment = PaysonAPI::V1::Requests::Payment.new(
  return_url,
  cancel_url,
  ipn_url,
  memo,
  sender,
  receivers
)
payment.order_items = order_items

response = PaysonAPI::V1::Client.initiate_payment(payment)

if response.success?
  # Redirect to response.forward_url
else
  puts response.errors
end
```

### Requesting payment details

```ruby
token = 'token-received-from-payment-request'

payment_details = PaysonAPI::V1::Requests::PaymentDetails.new(token)

response = PaysonAPI::V1::Client.get_payment_details(payment_details)

if response.success?
  # Do stuff with response object
else
  puts response.errors
end
```

### Updating a payment

```ruby
token = 'token-received-from-payment-request'
action = 'CANCELORDER'

payment_update = PaysonAPI::V1::Requests::PaymentUpdate.new(token, action)

response = PaysonAPI::V1::Client.update_payment(payment_update)

if response.success?
  # Do stuff with response object
else
  puts response.errors
end
```

### Validating an IPN response

This example assumes the use of the Rails web framework.

```ruby
class Payson < ApplicationController
  def ipn_responder
    request_body = request.body.read
    ipn_response = PaysonAPI::V1::Responses::IPN.new(request_body)

    # Create a new IPN request object containing the raw response from above
    ipn_request = PaysonAPI::V1::Requests::IPN.new(ipn_response.raw)

    validate = PaysonAPI::V1::Client.validate_ipn(ipn_request)

    unless validate.verified?
      raise "Something went terribly wrong."
    end

    # Do business transactions, e.g. update the corresponding order:
    #   order = Order.find_by_payson_token(ipn_response.token)
    #   order.payson_status = ipn_response.status
    #   order.save!
  end
end
```

## Todo

Document the code for the Payson Checkout v2 processes.

## Build Status

[![Build Status](https://travis-ci.org/stoffus/payson_api.svg?branch=master)](https://travis-ci.org/stoffus/payson_api)

## Questions, Feedback

Feel free to message me on Github (stoffus).

## Copyright

Copyright (c) 2021 Christopher Svensson.
