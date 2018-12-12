# frozen_string_literal: true

require          'set'
require 'benchmark'
require_relative '../inputs/december_01_input'

module AdventOfCode
  module Days
    class December01 < Day
      class << self
        include AdventOfCode::Inputs::December01Input

        # Solves the December 1st Silver Puzzle
        #
        # @return [Integer<484>] the sum of all given frequency changes
        def sum_frequency_changes!
          FREQUENCY_CHANGES.sum(INITIAL_FREQUENCY)
        end

        # Solves the December 1st Gold Puzzle
        #
        # @param  list [Set] the list of known frequencies
        # @param  freq [Integer] initial frequency to apply +change+ to
        # @return [Integer<367>] the first frequency to repeat in +list+
        def find_repeated_frequency!(list: Set.new, freq: INITIAL_FREQUENCY)
          FREQUENCY_CHANGES.each do |change|
            return freq unless list.add?(freq)
            freq += change
          end
          find_repeated_frequency!(list: list, freq: freq)
        end
      end

      SILVER_PUZZLE = {
        answer:     :sum_frequency_changes!,
        class_name: :December01,
        date:       formatted_date,
        message:    'The resulting frequency:',
        type:       :SILVER
      }.freeze

      GOLD_PUZZLE = {
        answer:     :find_repeated_frequency!,
        class_name: :December01,
        date:       formatted_date,
        message:    'The first frequency to repeat:',
        type:       :GOLD
      }.freeze

      private

      INITIAL_FREQUENCY = 0
      private_constant :INITIAL_FREQUENCY

    end
  end
end
