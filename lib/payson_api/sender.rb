module PaysonAPI
class Sender
  attr_accessor :email, :first_name, :last_name

  def initialize(email, first_name, last_name)
    @email = email
    @first_name = first_name
    @last_name = last_name
  end

  def to_hash
    {}.tap do |hash|
      hash['senderEmail'] = @email
      hash['senderFirstName'] = @first_name
      hash['senderLastName'] = @last_name
    end
  end
end
end
