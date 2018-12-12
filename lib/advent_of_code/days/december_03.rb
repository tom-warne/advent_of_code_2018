# frozen_string_literal: true

require_relative '../inputs/december_03_input'

module AdventOfCode
  module Days
    class December03 < Day
      include AdventOfCode::Inputs::December03Input

      class << self

        # Solves the December 3rd Silver Puzzle
        #
        # @return [Integer<114946>] the number of overlapping square inches of fabric
        def find_number_of_overlaps!
          FABRIC.values.flat_map(&:values).count { |val| val > 1 }
        end

        # Solves the December 3rd Gold Puzzle
        #
        # @return [Int<877>] the id of the only claim that is not overlapping
        def find_claim_without_overlap!
          PARSED_FABRIC_CUTS.each.with_index(1) do |(left, top, width, height), index|
            catch :overlap do
              width.times do |w|
                height.times do |h|
                  throw :overlap if FABRIC[left + w][top + h] > 1
                end
              end
              return index
            end
          end
        end
      end

      SILVER_PUZZLE = {
        answer:     :find_number_of_overlaps!,
        class_name: :December03,
        date:       formatted_date,
        message:    'The number of overlapping square inches of fabric:',
        type:       :SILVER
      }.freeze

      GOLD_PUZZLE = {
        answer:     :find_claim_without_overlap!,
        class_name: :December03,
        date:       formatted_date,
        message:   'The only claim without overlap:',
        type:      :GOLD
      }.freeze

      private

      # @! group Private Constants
      # Parse the cuts into:
      #   [[left, top, width, height],...]
      #
      PARSED_FABRIC_CUTS =
        FABRIC_CUTS.split("\n").map do |str|
          str.slice((str.index('@') + 2)..-1).split(/[,:x]/).map(&:to_i)
        end

      # Map claims onto fabric. Each unit of fabric
      # contains how many times it is used.
      # @example
      #   [[1, 2, 1, 1, 3, 4, ...]
      #    [2, 2, 1, 2, 2, 4, ...]
      #    [2, 2, 1, 1, 2, 4, ...], ...]
      FABRIC =
        PARSED_FABRIC_CUTS
          .each_with_object(COUNTING_HASH_2D.dup) do |(left, top, width, height), fabric|
            width.times do |w|
              height.times do |h|
                fabric[left + w][top + h] += 1
              end
            end
          end

      private_constant :PARSED_FABRIC_CUTS
      private_constant :FABRIC
      # @!endgroup
    end
  end
end
