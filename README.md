# Payson API

A zero dependency, pure Ruby utility to handle requests against the Payson payment gateway API.

## Supported Ruby versions

* 2.6
* 2.7
* 3.0

## Installation

Put this line in your Gemfile:

    gem 'payson_api'

Then bundle:

    $ bundle

## Usage (v2)

This explains how to use this gem with the [Payson Checkout v2 API](https://tech.payson.se/paysoncheckout2).

### General configuration options

You need to configure the gem with your own Payson credentials through the `PaysonAPI::V2.configure` method:

```ruby
PaysonAPI::V2.configure do |config|
  config.api_user_id = 'XXXX'
  config.api_password = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
end
```

Please note that if `config.api_user_id` is set to 4, the client will go into test mode. Valid test access credentials could be found in their [documentation](https://tech.payson.se/#Testing/sandbox).

For more detailed testing you may create your own test agent for use in the test environment. Use `config.test_mode = true`

### Showing account info

```ruby
account = PaysonAPI::V2::Client.get_account
```

### Creating a checkout

```ruby
request = PaysonAPI::V2::Requests::CreateCheckout.new
request.merchant.checkout_uri = 'http://localhost/checkout'
request.merchant.confirmation_uri = 'http://localhost/confirmation'
request.merchant.notification_uri = 'http://localhost/notification'
request.merchant.terms_uri = 'http://localhost/terms'
request.order.currency = 'sek'
request.order.items << PaysonAPI::V2::Requests::OrderItem.new.tap do |item|
  item.name = 'My product name'
  item.unit_price = 1000
  item.quantity = 3
  item.reference = 'product-1'
end

checkout = PaysonAPI::V2::Client.create_checkout(request)

# Continue by rendering the HTML from checkout.snippet.
```

### Updating a checkout

```ruby
checkout = PaysonAPI::V2::Client.get_checkout(checkout_id)

request = PaysonAPI::V2::Requests::UpdateCheckout.new
request.id = checkout.id
request.status = checkout.status
request.merchant.checkout_uri = checkout.merchant.checkout_uri
request.merchant.confirmation_uri = checkout.merchant.confirmation_uri
request.merchant.notification_uri = checkout.merchant.notification_uri
request.merchant.terms_uri = checkout.merchant.terms_uri
request.order.currency = 'eur'
request.order.items << PaysonAPI::V2::Requests::OrderItem.new.tap do |item|
  item.name = 'My product name'
  item.unit_price = 200
  item.quantity = 3
  item.reference = 'product-1'
end
request.order.items << PaysonAPI::V2::Requests::OrderItem.new.tap do |item|
  item.name = 'Another product name'
  item.unit_price = 600
  item.quantity = 1
  item.reference = 'product-2'
end

checkout = PaysonAPI::V2::Client.update_checkout(request)
```

## Usage (v1)

This explains how to use the [Payson 1.0 API](https://tech.payson.se/paysoncheckout1).

### General configuration options

You need to configure the gem with your own Payson credentials through the `PaysonAPI::V1.configure` method:

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
payment = PaysonAPI::V1::Requests::Payment.new
payment.return_url = 'http://localhost/payson/success'
payment.cancel_url = 'http://localhost/payson/cancel'
payment.ipn_url = 'http://localhost/payson/ipn'
payment.memo = 'Sample order description'
payment.sender = PaysonAPI::V1::Sender.new.tap do |s|
  s.email = 'mycustomer@mydomain.com'
  s.first_name = 'My'
  s.last_name = 'Customer'
end

payment.receivers = []
payment.receivers << PaysonAPI::V1::Receiver.new.tap do |r|
  r.email = 'me@mydomain.com'
  r.amount = 100
  r.first_name = 'Me'
  r.last_name = 'Just me'
  r.primary = true
end

payment.order_items = []
payment.order_items << PaysonAPI::V1::OrderItem.new.tap do |i|
  i.description = 'Order item description'
  i.unit_price = 100
  i.quantity = 1
  i.tax = 0
  i.sku = 'MY-ITEM-1'
end

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

    validation = PaysonAPI::V1::Client.validate_ipn(ipn_request)

    unless validation.verified?
      raise "Something went terribly wrong"
    end

    # Do business transactions, e.g. update the corresponding order:
    #   order = Order.find_by_payson_token(ipn_response.token)
    #   order.payson_status = ipn_response.status
    #   order.save!
  end
end
```

## Todo

Nothing at the moment.

## Project Status

[![Build Status](https://travis-ci.org/stoffus/payson_api.svg?branch=master)](https://travis-ci.org/stoffus/payson_api) [![Gem Version](https://badge.fury.io/rb/payson_api.svg)](https://badge.fury.io/rb/payson_api)

## Questions, Feedback

Feel free to message me on [GitHub](https://github.com/stoffus).

## Copyright

Copyright (c) 2021 Christopher Svensson.
