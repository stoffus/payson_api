# frozen_string_literal: true

require 'cgi'

module PaysonAPI
  module V1
    module Responses
      class PaymentDetails
        attr_accessor :envelope, :purchase_id, :sender_email, :status,
                      :payment_type, :guarantee_status, :guarantee_deadline_at,
                      :invoice_status, :custom, :tracking_id, :receivers, :currency,
                      :order_items, :errors, :fundings, :token, :shipping_address

        def initialize(data)
          @envelope = PaysonAPI::V1::Envelope.parse(data)
          @purchase_id = data['purchaseId']
          @payment_type = data['type']
          @comment = data['custom']
          @tracking_id = data['trackingId']
          @currency = data['currencyCode']
          @sender_email = data['senderEmail']
          @status = data['status']
          @token = data['token']
          @fundings = PaysonAPI::V1::Funding.parse(data)
          @receivers = PaysonAPI::V1::Receiver.parse(data)
          @order_items = PaysonAPI::V1::OrderItem.parse(data)
          @errors = PaysonAPI::V1::RemoteError.parse(data)
          append_payment_type_conditionals
        end

        def append_payment_type_conditionals
          case @payment_type
          when 'GUARANTEE'
            @guarantee_status = data['guaranteeStatus']
            @guarantee_deadline_at = Time.parse(CGI.unescape(data['guaranteeDeadlineTimestamp']))
          when 'INVOICE'
            @invoice_status = data['invoiceStatus']
            if %w[ORDERCREATED SHIPPED DONE CREDITED].include?(@invoice_status)
              @shipping_address = PaysonAPI::V1::ShippingAddress.parse(data)
            end
          end
        end

        def success?
          @envelope.ack == 'SUCCESS'
        end
      end
    end
  end
end
