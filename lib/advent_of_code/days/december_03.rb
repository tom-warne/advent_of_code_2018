# frozen_string_literal: true

require_relative '../inputs/december_03_input.rb'

module AdventOfCode
  module Days
    class December03 < Day
      include AdventOfCode::Inputs::December03Input

      # Solves the December 3rd Silver Puzzle
      #
      # @return [Integer<114946>] the number of overlapping square inches of fabric
      def self.find_number_of_overlaps!
        matrix = Hash.new { |h, k| h[k] = Hash.new(0) }

        parsed_input.each do |left, top, width, height|
          width.times  do |w|
            height.times do |h|
              matrix[left + w][top + h] += 1
            end
          end
        end

        matrix
          .map { |row, cols| cols.map { |col, cell| cell > 1 }.count(true) }
          .sum
      end

      SILVER_PUZZLE = {
        answer:     :find_number_of_overlaps!,
        class_name: :December03,
        date:       DATE,
        message:    'The number of overlapping square inches of fabric:',
        type:       :SILVER
      }

      # Solves the December 3rd Gold Puzzle
      #
      # @return [String<>] the string of characters shared by the two ids
      def self.tbd!
        :tbd
      end

      GOLD_PUZZLE = {
        answer:     :tbd!,
        class_name: :December03,
        date:       DATE,
        message:   'The characters shared by the ids are',
        type:      :GOLD
      }

      private

      # Parse the puzzle input into a usable format
      #
      # @private
      def self.parsed_input
        FABRIC_CUTS
          .split("\n")
          .map { |str| str.slice((str.index('@') + 2)..-1).split(/[,:x ]/) }
          .map { |arr| arr.reject(&:empty?) }
          .map { |arr| arr.map(&:to_i) }
      end

    end
  end
end
