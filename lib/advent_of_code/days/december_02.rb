# frozen_string_literal: true

require_relative '../inputs/december_02_input.rb'

module AdventOfCode
  module Days
    class December02 < Day
      include AdventOfCode::Inputs::December02Input

      def self.date
        Date.parse(class_name)
      end


      # Solves the December 2nd Silver Puzzle
      #
      # @return [Integer<6888>] the checksum of all given ids
      def self.calculate_checksum!
        BOX_IDS
          .flat_map { |id| id.chars.map(&id.method(:count)) & [2, 3] }
          .partition(&:even?)
          .map(&:size)
          .reduce(:*)
      end

      SILVER_PUZZLE = {
        answer:  calculate_checksum!,
        date:    date,
        message: 'The resulting checksum is',
        type:    :SILVER
      }
      #
      # # Solves the December 2nd Gold Puzzle
      # #
      # # @param  [Hash<Integer, Nil>] freqs the table of frequencies that `freq` is being appended to
      # # @param  [Integer]            freq  the frequency to start the table on
      # #
      # # @return [Integer<367>] the first frequency that is already contained in `freqs`
      # def self.find_repeated_frequency!(freqs: {INITIAL_FREQUENCY => nil}, freq: INITIAL_FREQUENCY)
      #   FREQUENCY_CHANGES.each do |change|
      #     freq += change
      #     freqs.has_key?(freq) ? (return freq) : freqs[freq] = nil
      #   end
      #   find_repeated_frequency!(freqs: freqs, freq: freq)
      # end
      #
      GOLD_PUZZLE = {
        answer:  nil,
        date:    date,
        message: 'tbd',
        type:    :GOLD
      }

    end
  end
end
