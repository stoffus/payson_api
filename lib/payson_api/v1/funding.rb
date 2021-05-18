# frozen_string_literal: true

module PaysonAPI
  module V1
    class Funding
      FORMAT_STRING = "fundingList.fundingConstraint(%d).%s"
      attr_accessor :constraint

      def constraint=(value)
        unless PaysonAPI::V1::FUNDING_CONSTRAINTS.include?(value)
          raise "Unknown funding constraint: #{value}"
        end

        @constraint = value
      end

      def self.to_hash(fundings)
        {}.tap do |hash|
          fundings.each_with_index do |funding, index|
            hash.merge!({
              FORMAT_STRING % [index, 'constraint'] => funding.constraint
            })
          end
        end
      end

      def self.parse(data)
        [].tap do |fundings|
          i = 0
          while data[FORMAT_STRING % [i, 'constraint']]
            fundings << self.new.tap do |f|
              f.constraint = data[FORMAT_STRING % [i, 'constraint']]
            end
            i += 1
          end
        end
      end
    end
  end
end
