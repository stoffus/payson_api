# frozen_string_literal: true

module PaysonAPI
  module V1
    module Requests
      class Payment
        attr_accessor :return_url, :cancel_url, :ipn_url, :memo, :sender, :receivers,
          :locale, :currency, :tracking_id, :invoice_fee, :order_items, :fundings,
          :fees_payer, :guarantee_offered, :custom

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
          unless LOCALES.include?(locale)
            raise PaysonAPI::V1::Errors::UnknownCurrencyError(locale = locale)
          end
          hash['localeCode'] = locale
        end

        def append_currency(hash, currency)
          unless PaysonAPI::V1::CURRENCIES.include?(currency)
            raise PaysonAPI::V1::Errors::UnknownCurrencyError(currency = currency)
          end
          hash['currencyCode'] = currency
        end

        def append_guarantee(hash, guarantee_offered)
          unless PaysonAPI::V1::GUARANTEE_OFFERINGS.include?(guarantee_offered)
            raise PaysonAPI::V1::Errors::UnknownGuaranteeOffering(guarantee_offering = guarantee_offered)
          end
          hash['guaranteeOffered'] = guarantee_offered
        end

        def append_fees_payer(hash, fees_payer)
          unless PaysonAPI::V1::FEES_PAYERS.include?(fees_payer)
            raise PaysonAPI::V1::Errors::UnknownFeesPayer(fees_payer = fees_payer)
          end
          hash['feesPayer'] = fees_payer
        end
      end
    end
  end
end
