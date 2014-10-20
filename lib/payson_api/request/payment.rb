module PaysonAPI
module Request
class Payment
  attr_accessor :return_url, :cancel_url, :ipn_url, :memo, :sender, :receivers,
    :locale, :currency, :tracking_id, :invoice_fee, :order_items, :fundings,
    :fees_payer, :guarantee_offered, :custom

  def initialize(return_url, cancel_url, ipn_url, memo, sender, receivers, custom)
    @return_url = return_url
    @cancel_url = cancel_url
    @ipn_url = ipn_url
    @memo = memo
    @sender = sender
    @receivers = receivers
    @custom = custom
  end

  def to_hash
    {}.tap do |hash|
      # Append mandatory params
      hash['returnUrl'] = @return_url
      hash['cancelUrl'] = @cancel_url
      hash['memo'] = @memo
      hash.merge!(@sender.to_hash)
      hash.merge!(Receiver.to_hash(@receivers))

      # Append optional params
      append_locale(hash, @locale) if @locale
      append_currency(hash, @currency) if @currency
      append_fees_payer(hash, @fees_payer) if @fees_payer
      append_guarantee(hash, @guarantee_offered) if @guarantee_offered
      hash.merge!(OrderItem.to_hash(@order_items)) if @order_items
      hash.merge!(Funding.to_hash(@fundings)) if @fundings
      hash['ipnNotificationUrl'] = @ipn_url if @ipn_url
      hash['invoiceFee'] = @invoice_fee if @invoice_fee
      hash['trackingId'] = @tracking_id if @tracking_id
      hash['custom'] = @custom if @custom
    end
  end

private

  def append_locale(hash, locale)
    raise "Unknown locale: #{locale}" if !LOCALES.include?(locale)
    hash['localeCode'] = locale
  end

  def append_currency(hash, currency)
    raise "Unknown currency: #{currency}" if !CURRENCIES.include?(currency)
    hash['currencyCode'] = currency
  end

  def append_guarantee(hash, guarantee_offered)
    if !GUARANTEE_OFFERINGS.include?(guarantee_offered)
      raise "Unknown guarantee offering: #{guarantee_offered}"
    end
    hash['guaranteeOffered'] = guarantee_offered
  end

  def append_fees_payer(hash, fees_payer)
    if !FEES_PAYERS.include?(fees_payer)
      raise "Unknown fees payer: #{fees_payer}"
    end
    hash['feesPayer'] = fees_payer
  end
end
end
end
