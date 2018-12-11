# frozen_string_literal: true

require_relative '../inputs/december_XX_input.rb'

module AdventOfCode
  module Days
    class DecemberXX < Day
      include AdventOfCode::Inputs::DecemberXXInput

      # Solves the December YY Silver Puzzle
      #
      # @return [?<>] ??
      def self.tbd_silver!
      end

      SILVER_PUZZLE = {
        answer:     :tbd_silver!,
        class_name: :DecemberXX,
        date:       formatted_date,
        message:    ':',
        type:       :SILVER
      }

      # Solves the December YY Gold Puzzle
      #
      # @return [?<>] ??
      def self.tbd_gold!
      end

      GOLD_PUZZLE = {
        answer:     :tbd_gold!,
        class_name: :DecemberXX,
        date:       formatted_date,
        message:    ':',
        type:       :GOLD
      }

    end
  end
end
