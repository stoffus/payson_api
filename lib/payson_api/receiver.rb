require 'cgi'

module PaysonAPI
class Receiver
  FORMAT_STRING = "receiverList.receiver(%d).%s"
  attr_accessor :email, :amount, :first_name, :last_name, :primary

  def initialize(email, amount, first_name, last_name, primary = true)
    @email = email
    @amount = amount
    @first_name = first_name
    @last_name = last_name
    @primary = primary
  end

  def self.to_hash(receivers)
    {}.tap do |hash|
      receivers.each_with_index do |receiver, index|
        raise "Invalid receiver" unless receiver.instance_of?(self)
        hash.merge!({
          FORMAT_STRING % [index, 'email'] => receiver.email,
          FORMAT_STRING % [index, 'amount'] => receiver.amount,
          FORMAT_STRING % [index, 'firstName'] => receiver.first_name,
          FORMAT_STRING % [index, 'lastName'] => receiver.last_name,
          FORMAT_STRING % [index, 'primary'] => receiver.primary
        })
      end
    end
  end

  def self.parse(data)
    [].tap do |receivers|
      i = 0
      while data[FORMAT_STRING % [i, 'email']]
        email = CGI.unescape(data[FORMAT_STRING % [i, 'email']].to_s)
        amount = data[FORMAT_STRING % [i, 'amount']]
        first_name = CGI.unescape(data[FORMAT_STRING % [i, 'firstName']].to_s)
        last_name = CGI.unescape(data[FORMAT_STRING % [i, 'lastName']].to_s)
        primary = data[FORMAT_STRING % [i, 'primary']]
        receivers << self.new(email, amount, first_name, last_name, primary)
        i += 1
      end
    end
  end
end
end
