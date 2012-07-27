require 'cgi'

module PaysonAPI
class Envelope
  attr_accessor :ack, :timestamp, :correlation_id
  FORMAT_STRING = "responseEnvelope.%s"

  def initialize(ack, timestamp, correlation_id)
    @ack = ack
    @timestamp = timestamp
    @correlation_id = correlation_id
  end

  def self.parse(data)
    ack = data[FORMAT_STRING % 'ack']
    timestamp = DateTime.parse(CGI.unescape(data[FORMAT_STRING % 'timestamp'].to_s))
    correlation_id = data[FORMAT_STRING % 'correlationId']
    self.new(ack, timestamp, correlation_id)
  end
end
end
