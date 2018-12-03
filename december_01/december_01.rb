# frozen_string_literal: true

require_relative 'input'

class AdventOfCode
  class December01
    include Input

    # TODO Base this off of the class name -TW
    DATE = Date.parse('December01')

    # # #
    # Silver Puzzle
    # @return 484
    def self.sum_frequency_changes!
      FREQUENCY_CHANGES.sum(INITIAL_FREQUENCY)
    end

    SILVER_PUZZLE = {
      answer:  sum_frequency_changes!,
      date:    DATE,
      message: 'The resulting frequency is',
      type:    :SILVER
    }

    # # #
    # Gold Puzzle
    # @return 367
    def self.find_repeated_frequency!(freqs: {INITIAL_FREQUENCY => nil}, freq: INITIAL_FREQUENCY)
      FREQUENCY_CHANGES.each do |change|
        freq += change

        freqs.has_key?(freq) ? (return freq) : freqs[freq] = nil
      end

      find_repeated_frequency!(freqs: freqs, freq: freq)
    end

    GOLD_PUZZLE = {
      answer:  find_repeated_frequency!,
      date:    DATE,
      message: 'The first frequency to repeat is',
      type:    :GOLD
    }

  end
end
