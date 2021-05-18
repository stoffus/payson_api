module PaysonAPI
  module V2
    module Models
      class Account
        attr_accessor :account_email, :status, :merchant_id, :enabled_for_invoice,
          :enabled_for_payment_plan, :enabled_for_recurring_payments

        def self.from_hash(hash)
          self.new.tap do |account|
            account.account_email = hash['accountEmail']
            account.status = hash['status']
            account.merchant_id = hash['merchantId']
            account.enabled_for_invoice = hash['enabledForInvoice']
            account.enabled_for_payment_plan = hash['enabledForpaymentPlan']
            account.enabled_for_recurring_payments = hash['enabledForRecurringPayments']
          end
        end
      end
    end
  end
end
