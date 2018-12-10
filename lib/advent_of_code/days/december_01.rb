# frozen_string_literal: true

require_relative '../inputs/december_01_input.rb'

module AdventOfCode
  module Days
    class December01 < Day
      include AdventOfCode::Inputs::December01Input

      DATE = Date.parse(class_name)

      # Solves the December 1st Silver Puzzle
      #
      # @return [Integer<484>] the sum of all given frequency changes
      def self.sum_frequency_changes!
        FREQUENCY_CHANGES.sum(INITIAL_FREQUENCY)
      end

      SILVER_PUZZLE = {
        answer:     :sum_frequency_changes!,
        class_name: :December01,
        date:       DATE,
        message:    'The resulting frequency:',
        type:       :SILVER
      }

      # Solves the December 1st Gold Puzzle
      #
      # @param  freqs [Hash<Integer, Nil>] the table of frequencies that +freq+ is being appended to
      # @param  freq  [Integer] the frequency to start the table on
      # @return [Integer<367>] the first frequency that is already contained in +freqs+
      def self.find_repeated_frequency!(freqs: {INITIAL_FREQUENCY => nil}, freq: INITIAL_FREQUENCY)
        FREQUENCY_CHANGES.each do |change|
          freq += change
          freqs.has_key?(freq) ? (return freq) : freqs[freq] = nil
        end
        find_repeated_frequency!(freqs: freqs, freq: freq)
      end

      GOLD_PUZZLE = {
        answer:     :find_repeated_frequency!,
        class_name: :December01,
        date:       DATE,
        message:    'The first frequency to repeat:',
        type:       :GOLD
      }

    end
  end
end
