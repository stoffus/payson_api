require 'cgi'

module PaysonAPI
class RemoteError
  attr_accessor :id, :message, :parameters
  FORMAT_STRING = "errorList.error(%d).%s"

  def initialize(id, message, parameters)
    @id = id
    @message = message
    @parameters = parameters
  end

  def self.parse(data)
    [].tap do |errors|
      i = 0
      while data[FORMAT_STRING % [i, 'errorId']]
        id = data[FORMAT_STRING % [i, 'errorId']]
        message = CGI.unescape(data[FORMAT_STRING % [i, 'message']])
        parameters = CGI.unescape(data[FORMAT_STRING % [i, 'parameter']])
        errors << self.new(id, message, parameters)
        i += 1
      end
    end
  end

  def to_s
    "ID: #{@id}, Message: #{@message}, Parameters: #{@parameters}"
  end
end
end
