module PaysonAPI
class PayData
  attr_accessor :return_url, :cancel_url, :ipn_url, :memo, :sender, :receivers,
    :locale, :currency, :tracking_id, :invoice_fee, :order_items

  def initialize(return_url, cancel_url, ipn_url, memo, sender, receivers)
    @return_url = return_url
    @cancel_url = cancel_url
    @ipn_url = ipn_url
    @memo = memo
    @sender = sender
    @receivers = receivers
  end

  def to_hash
    {}.tap do |hash|
      hash['returnUrl'] = @return_url
      hash['cancelUrl'] = @cancel_url
      hash['ipnNotificationUrl'] = @ipn_url unless @ipn_url.empty?
      hash['memo'] = @memo
      hash['localeCode'] = LOCALES[@locale] if @locale
      hash['currencyCode'] = CURRENCIES[@currency] if @currency
      hash.merge!(Receiver.to_hash(@receivers))
      hash.merge!(@sender.to_hash)
      hash.merge!(OrderItem.to_hash(@order_items)) if @order_items
      hash['invoiceFee'] = @invoice_fee if @invoice_fee
      hash['trackingId'] = @tracking_id if @tracking_id
    end
  end

  def to_s
    to_hash.to_s
  end
end
end