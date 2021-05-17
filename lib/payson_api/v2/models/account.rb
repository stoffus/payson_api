module PaysonAPI
  module V2
    module Models
      class Account
        attr_accessor :account_email, :status, :merchant_id, :enabled_for_invoice,
          :enabled_for_payment_plan, :enabled_for_recurring_payments

        def self.from_json(json)
          self.new.tap do |account|
            account.account_email = json['accountEmail']
            account.status = json['status']
            account.merchant_id = json['merchantId']
            account.enabled_for_invoice = json['enabledForInvoice']
            account.enabled_for_payment_plan = json['enabledForpaymentPlan']
            account.enabled_for_recurring_payments = json['enabledForRecurringPayments']
          end
        end
      end
    end
  end
end
