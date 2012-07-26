require 'cgi'

module PaysonAPI
class RemoteError
  attr_accessor :id, :message, :parameter
  FORMAT_STRING = "errorList.error(%d).%s"

  def initialize(id, message, parameter)
    @id = id
    @message = message
    @parameter = parameter
  end

  def self.parse(data)
    [].tap do |errors|
      i = 0
      while data[FORMAT_STRING % [i, 'errorId']]
        id = data[FORMAT_STRING % [i, 'errorId']]
        message = CGI.unescape(data[FORMAT_STRING % [i, 'message']])
        parameter = CGI.unescape(data[FORMAT_STRING % [i, 'parameter']])
        errors << self.new(id, message, parameter)
        i += 1
      end
    end
  end

  def to_s
    "ID: #{@id}, Message: #{@message}, Parameter: #{@parameter}"
  end
end
end
