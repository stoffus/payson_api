# frozen_string_literal: true

module PaysonAPI
  module V2
    module Requests
      class ListCheckouts
        attr_accessor :page_size, :page

        def initialize(page_size = 20, page = 1)
          @page_size = page_size
          @page = page
        end

        def to_hash
          {}.tap do |hash|
            hash['pageSize'] = @page_size
            hash['page'] = @page
          end
        end
      end
    end
  end
end
