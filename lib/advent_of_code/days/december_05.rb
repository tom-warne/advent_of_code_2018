# frozen_string_literal: true

require_relative '../inputs/december_05_input.rb'

module AdventOfCode
  module Days
    class December05 < Day
      include AdventOfCode::Inputs::December05Input

      # Pairs of units that will destroy each other in the reaction (eg: aA Aa)
      DESTRUCTION_PAIRS = /([[:upper:][:lower:]])(?!\1)(?i)\1/.freeze

      # Solves the December 5th Silver Puzzle
      #
      # @param  [String] chain the polymer chain from which to remove units
      # @return [Integer<10978>] the number of chemical units left after the reaction
      def self.count_units_left!(chain: POLYMER_CHAIN)
        orig_chain_length = chain.length
        (+chain).gsub!(DESTRUCTION_PAIRS, '')

        orig_chain_length == chain.length ? chain.length : count_units_left!(chain: chain)
      end

      SILVER_PUZZLE = {
        answer:     :count_units_left!,
        class_name: :December05,
        date:       DATE,
        message:    'Number of units left after reaction:',
        type:       :SILVER
      }

      # Solves the December 5th Gold Puzzle
      #
      # @return [?<>] ??
      def self.tbd_gold!
      end

      GOLD_PUZZLE = {
        answer:     :tbd_gold!,
        class_name: :December05,
        date:       DATE,
        message:    ':',
        type:       :GOLD
      }

    end
  end
end
