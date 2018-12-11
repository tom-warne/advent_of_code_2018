# frozen_string_literal: true

module AdventOfCode
  module Days
    class Day

      def self.class_name
        name.to_s.gsub(/^.*::/, '')
      end

      def self.formatted_date
        Date.parse(class_name).strftime("%B %d")
      end

      PUZZLE_TYPES = %i[SILVER GOLD].freeze

      COUNTING_HASH    = Hash.new(0).freeze
      COUNTING_HASH_2D = Hash.new { |h, k| h[k] = COUNTING_HASH.dup }.freeze
      INFINITE_HASH    = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    end
  end
end
