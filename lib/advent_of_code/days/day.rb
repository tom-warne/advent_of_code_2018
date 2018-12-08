# frozen_string_literal: true

module AdventOfCode
  module Days
    class Day

      def self.class_name
        name.to_s.gsub(/^.*::/, '')
      end

      DATE = Date._parse(class_name).empty? ? Date.today : Date.parse(class_name)

      PUZZLE_TYPES = %i[SILVER GOLD].freeze
    end
  end
end
