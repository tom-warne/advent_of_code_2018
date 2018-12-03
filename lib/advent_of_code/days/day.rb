# frozen_string_literal: true

module AdventOfCode
  module Days
    class Day

      def self.class_name
        name.to_s.gsub(/^.*::/, '')
      end

      def self.date
        raise 'Must be implemented by inheriting classes'
      end

      PUZZLE_TYPES = %i[SILVER GOLD].freeze


    end
  end
end
