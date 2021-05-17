require 'cgi'

module PaysonAPI
  module V1
    module Response
      class PaymentDetails
        attr_accessor :envelope, :purchase_id, :sender_email, :status,
          :payment_type, :guarantee_status, :guarantee_deadline_at,
          :invoice_status, :custom, :tracking_id, :receivers, :currency,
          :order_items, :errors, :fundings, :token, :shipping_address

        def initialize(data)
          @envelope = Envelope.parse(data)
          @purchase_id = data['purchaseId']
          @payment_type = data['type']
          @comment = data['custom']
          @tracking_id = data['trackingId']
          @currency = data['currencyCode']
          @sender_email = data['senderEmail']
          @status = data['status']
          @token = data['token']
          @fundings = Funding.parse(data)
          @receivers = Receiver.parse(data)
          @order_items = OrderItem.parse(data)
          @errors = RemoteError.parse(data)

          case @payment_type
          when 'GUARANTEE'
            @guarantee_status = data['guaranteeStatus']
            @guarantee_deadline_at = Time.parse(CGI.unescape(data['guaranteeDeadlineTimestamp']))
          when 'INVOICE'
            @invoice_status = data['invoiceStatus']
            if %w[ORDERCREATED SHIPPED DONE CREDITED].include?(@invoice_status)
              @shipping_address = ShippingAddress.parse(data)
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
