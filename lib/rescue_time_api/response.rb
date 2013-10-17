require 'date'
require 'forwardable'

module RescueTimeApi
  class Response

      attr_accessor :response
      extend Forwardable
      def_delegators :@response, :body, :headers

      def initialize(response)
        @response = response
      end

      def row_headers
        @row_headers ||= body['row_headers'].map { |row_name| key_mapping[row_name] }
      end

      def rows
        @rows ||= body["rows"].map { |row| map_row(row) }
      end

      def map_row(row)
        mapped = Hash[row_headers.zip(row)]
        mapped['date'] = DateTime.parse(mapped['date']) if mapped['date']
        ['second','rank','people','productivity'].each do |key|
          mapped[key] = mapped[key].to_i if mapped[key]
        end
        mapped
      end

      def key_mapping
        {
          "Person" => 'person',
          "Rank" => 'rank',
          "Time Spent (seconds)" => 'seconds',
          "Number of People" => 'people',
          "Activity" => 'activity',
          "Category" => 'category',
          "Productivity" => 'productivity',
          "Date" => "date"
        }
      end

  end
end