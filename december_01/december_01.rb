# frozen_string_literal: true

require_relative 'input'

class AdventOfCode
  class December01
    include Input

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

    # Gold Puzzle
    # @return 367
    def self.find_repeated_frequency!(freqs: {INITIAL_FREQUENCY => nil}, next_f: INITIAL_FREQUENCY)
      FREQUENCY_CHANGES.each do |change|
        last_f = next_f
        next_f = last_f + change

        freqs.has_key?(next_f) ? return next_f : freqs[next_f] = last_f
      end

      find_repeated_frequency!(freqs: freqs, next_f: next_f, count: count)
    end

    GOLD_PUZZLE = {
      answer:  find_repeated_frequency!,
      date:    DATE,
      message: 'The first frequency to repeat is:',
      type:    :GOLD
    }

  end
end
