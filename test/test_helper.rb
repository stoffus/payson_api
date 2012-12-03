require 'yaml'

module TestHelper
  CONFIG = YAML.load_file('test/fixtures/config.yml')
  PAYMENT_DATA = YAML.load_file('test/fixtures/payment_data.yml')

  def setup
    PaysonAPI.configure do |config|
      config.api_user_id = CONFIG[:api_user_id]
      config.api_password = CONFIG[:api_password]
    end
  end

  def setup_payment_hash(include_order_items = false)
    @sender = PaysonAPI::Sender.new(
      PAYMENT_DATA[:sender][:email],
      PAYMENT_DATA[:sender][:first_name],
      PAYMENT_DATA[:sender][:last_name]
    )

    @receivers = []
    PAYMENT_DATA[:receivers].each do |receiver|
      @receivers << PaysonAPI::Receiver.new(
        receiver[:email],
        receiver[:amount],
        receiver[:first_name],
        receiver[:last_name],
        receiver[:primary]
      )
    end

    @payment = PaysonAPI::Request::Payment.new(
      PAYMENT_DATA[:return_url],
      PAYMENT_DATA[:cancel_url],
      PAYMENT_DATA[:ipn_url],
      PAYMENT_DATA[:memo],
      @sender,
      @receivers
    )

    @order_items = []
    PAYMENT_DATA[:order_items].each do |order_item|
      @order_items << PaysonAPI::OrderItem.new(
        order_item[:description],
        order_item[:unit_price],
        order_item[:quantity],
        order_item[:tax],
        order_item[:sku]
      )
    end

    @fundings = []
    PAYMENT_DATA[:fundings].each do |funding|
      @fundings << PaysonAPI::Funding.new(
        funding[:constraint]
      )
    end

    @payment.order_items = @order_items if include_order_items
    @payment.fundings = @fundings
    @payment.fees_payer = PAYMENT_DATA[:fees_payer]
    @payment.locale = PAYMENT_DATA[:locale]
    @payment.guarantee_offered = PAYMENT_DATA[:guarantee_offered]
    @payment.currency = PAYMENT_DATA[:currency]

    @payment_hash = @payment.to_hash
  end

  def initiate_payment
    setup_payment_hash
    PaysonAPI::Client.initiate_payment(@payment_hash)
  end

  def teardown
  end
end
