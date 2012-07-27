module PaysonAPI
module Response
class IPN
  attr_accessor :purchase_id, :sender_email, :status,
    :payment_type, :guarantee_status, :guarantee_deadline_at,
    :invoice_status, :custom, :tracking_id, :receivers, :currency,
    :order_items, :fundings, :token, :shipping_address
    :raw

  def initialize(data)
    @raw = data
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

    case @payment_type
    when 'GUARANTEE'
      @guarantee_status = data['guaranteeStatus']
      @guarantee_deadline_at = Time.at(data['guaranteeDeadlineTimestamp'])
    when 'INVOICE'
      @invoice_status = data['invoiceStatus']
      @shipping_address = ShippingAddress.parse(data)
    end
  end
end
end
end
