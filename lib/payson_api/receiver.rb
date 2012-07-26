module PaysonAPI
class Receiver
  FORMAT_STRING = "receiverList.receiver(%d).%s"
  attr_accessor :email, :amount

  def initialize(email, amount)
    @email = email
    @amount = amount
  end

  def self.to_hash(receivers)
    {}.tap do |hash|
      receivers.each_with_index do |receiver, index|
        raise "Invalid receiver" unless receiver.instance_of?(self)
        hash.merge!({
          FORMAT_STRING % [index, 'email'] => receiver.email,
          FORMAT_STRING % [index, 'amount'] => receiver.amount
        })
      end
    end
  end

  def self.parse(data)
    [].tap do |receivers|
      i = 0
      while data[FORMAT_STRING % [i, 'email']]
        email = data[FORMAT_STRING % [i, 'email']]
        amount = data[FORMAT_STRING % [i, 'amount']]
        receivers << self.new(email, amount)
        i += 1
      end
    end
  end
end
end
