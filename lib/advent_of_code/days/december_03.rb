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
        create_fabric!

        fabric
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
      # @return [Int<>] the id of the only claim that is not overlapping
      def self.find_claim_without_overlap!
        create_fabric!

        parsed_input.each.with_index(1) do |(left, top, width, height), index|
          overlap = false
          width.times do |w|
            height.times do |h|
              break overlap = true if fabric[left + w][top + h] > 1
            end
            break if overlap
          end
          return index unless overlap
        end
      end

      GOLD_PUZZLE = {
        answer:     :find_claim_without_overlap!,
        class_name: :December03,
        date:       DATE,
        message:   'The only claim without overlap:',
        type:      :GOLD
      }

      private

      # Map claims onto the fabric
      #
      # @private
      def self.create_fabric!
        return @fabric if defined? @fabric

        parsed_input.each do |left, top, width, height|
          width.times do |w|
            height.times do |h|
              self.fabric[left + w][top + h] += 1
            end
          end
        end
      end

      # Matrix for plotting fabric cuts.
      #
      # @private
      def self.fabric
        return @fabric if defined? @fabric
        @fabric = Hash.new { |h, k| h[k] = Hash.new(0) }
      end

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
