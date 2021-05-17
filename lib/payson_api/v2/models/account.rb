module PaysonAPI
  module V2
    module Models
      class Account
        attr_accessor :account_email, :status, :merchant_id, :enabled_for_invoice,
          :enabled_for_payment_plan, :enabled_for_recurring_payments
      end
    end
  end
end
