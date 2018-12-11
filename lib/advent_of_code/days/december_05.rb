# frozen_string_literal: true

require_relative '../inputs/december_05_input.rb'

module AdventOfCode
  module Days
    class December05 < Day
      include AdventOfCode::Inputs::December05Input

      # Pairs of units that will destroy each other in the reaction
      # @example
      #   Valid:   [Aa aA zZ Yy mM Mm]
      #   Invalid: [aa AA ZZ Yz mN Nm]
      DESTRUCTION_PAIRS = /([[:upper:][:lower:]])(?!\1)(?i)\1/.freeze

      # Solves the December 5th Silver Puzzle
      #
      # @param  chain [String] the polymer chain from which to remove units
      # @return [Integer<10978>] the number of chemical units left after the reaction
      def self.count_units_left!(chain: POLYMER_CHAIN)
        orig_chain_length = chain.length
        (+chain).gsub!(DESTRUCTION_PAIRS, '')

        orig_chain_length == chain.length ? chain.length : count_units_left!(chain: chain)
      end

      SILVER_PUZZLE = {
        answer:     :count_units_left!,
        class_name: :December05,
        date:       formatted_date,
        message:    'Number of units left after reaction:',
        type:       :SILVER
      }.freeze

      # Solves the December 5th Gold Puzzle
      # @todo Look into short circuiting each loop if
      #
      # @return [Integer<4840>] the shortest chain after removing one of the building types
      def self.minimum_after_removing_problem_type!
        (?a..?z)
          .map { |c| count_units_left!(chain: POLYMER_CHAIN.gsub(%r/#{c}|#{c.upcase}/, '')) }
          .min
      end

      GOLD_PUZZLE = {
        answer:     :minimum_after_removing_problem_type!,
        class_name: :December05,
        date:       formatted_date,
        message:    'Number of units after removing problem type:',
        type:       :GOLD
      }.freeze

    end
  end
end
