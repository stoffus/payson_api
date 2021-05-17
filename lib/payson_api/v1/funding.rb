module PaysonAPI
  module V1
    class Funding
      FORMAT_STRING = "fundingList.fundingConstraint(%d).%s"
      attr_accessor :constraint

      def initialize(constraint)
        if !FUNDING_CONSTRAINTS.include?(constraint)
          raise "Unknown funding constraint: #{constraint}"
        end
        @constraint = constraint
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
            constraint = data[FORMAT_STRING % [i, 'constraint']]
            fundings << self.new(constraint)
            i += 1
          end
        end
      end
    end
  end
end
