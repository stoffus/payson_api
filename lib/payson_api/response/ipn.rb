module PaysonAPI
module Response
class IPN
  attr_accessor :purchase_id, :sender_email, :status,
    :payment_type, :guarantee_status, :guarantee_deadline_at,
    :invoice_status, :custom, :tracking_id, :receivers, :currency,
    :order_items, :fundings, :token, :shipping_address, :raw, :hash

  def initialize(raw_data)
    @raw = raw_data
    data_hash = PaysonAPI::Client.params_to_hash(raw_data)
    @purchase_id = data_hash['purchaseId']
    @payment_type = data_hash['type']
    @comment = data_hash['custom']
    @tracking_id = data_hash['trackingId']
    @currency = data_hash['currencyCode']
    @sender_email = data_hash['senderEmail']
    @status = data_hash['status']
    @token = data_hash['token']
    @fundings = Funding.parse(data_hash)
    @receivers = Receiver.parse(data_hash)
    @order_items = OrderItem.parse(data_hash)
    @hash = data_hash['HASH']

    case @payment_type
    when 'GUARANTEE'
      @guarantee_status = data_hash['guaranteeStatus']
      @guarantee_deadline_at = Time.at(data_hash['guaranteeDeadlineTimestamp'])
    when 'INVOICE'
      @invoice_status = data_hash['invoiceStatus']
      @shipping_address = ShippingAddress.parse(data_hash)
    end
  end
end
end
end
