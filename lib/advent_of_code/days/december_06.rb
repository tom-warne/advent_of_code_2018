# frozen_string_literal: true

require          'matrix'
require_relative '../inputs/december_06_input.rb'

module AdventOfCode
  module Days
    class December06 < Day
      include AdventOfCode::Inputs::December06Input

      DATE = Date.parse(class_name)

      # X_MAX = COORDINATES.map(&:first).max  - X_OFFSET
      # Y_MAX = COORDINATES.map(&:second).max - Y_OFFSET


      # Transform coordinate system to begin on [0, 0]
      X_OFFSET = 42
      Y_OFFSET = 43
      ABS_COOR = COORDINATES.map { |x, y| [x - X_OFFSET, y - Y_OFFSET] }


      # Length of "Circle/Diamond" side is 2 * RADIUS
      # PI = 4
      # CIRCUMFERENCE = 8 * RADIUS

      # UNIT_CIRCLE_CARTESIAN = abs(x) + abs(y) = 1
      # UNIT_CIRCLE_POLAR     = 1 / (sin(theta) + cos(theta))

      # Solves the December 6th Silver Puzzle
      #
      # @return [Integer<>] area surronding most isolated point
      def self.find_largest_isolated_area!
      end

      SILVER_PUZZLE = {
        answer:     :find_largest_isolated_area!,
        class_name: :December06,
        date:       DATE,
        message:    'Size of area surronding most isolated point:',
        type:       :SILVER
      }

      # Solves the December 6th Gold Puzzle
      #
      # @return [?<>] ??
      def self.tbd_gold!
      end

      GOLD_PUZZLE = {
        answer:     :tbd_gold!,
        class_name: :December06,
        date:       DATE,
        message:    ':',
        type:       :GOLD
      }

      private


      def self.find_corners
        @corners = COOR.transpose.map(&:minmax).transpose
      end

      # [42, 43] => [0, 0]
      def self.lower_left_corner
        @corners.first
      end

      # [358, 337] => [316, 294]
      def self.upper_right_corner
        @corners.last
      end

      # 2D Array symbolyzing our starting points and surronding territories
      # @note Grid is built and accessed via +grid[y][x]+
      #
      # @return [Array<nil, nil>]
      def self.build_grid
        @grid = Array.new(ABS_COOR.map(&:last).max) { Array.new(ABS_COOR.map(&:first).max) { nil } }
      end

      def self.populate_grid
        ABS_COOR.each_with_index { |(x, y), i| @grid[y][x] = i }
      end

    end
  end
end
