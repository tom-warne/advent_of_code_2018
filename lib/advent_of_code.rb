# frozen_string_literal: true

# @author Tom Warne <thomaswarne@gmail.com>
module AdventOfCode
  require 'date'

  require_relative 'advent_of_code/puzzle_response'
  require_relative 'advent_of_code/solution_message'
  require_relative 'advent_of_code/days'

  # @!group Date Config
  START_DATE = Date.parse('2018-12-01').freeze
  END_DATE   = Date.parse('2018-12-05').freeze
  DATE_RANGE = (START_DATE..END_DATE).freeze

  # @!group Puzzle Config
  PUZZLE       = "AdventOfCode::Days::%{date}::%{type}_PUZZLE"
  PUZZLE_TYPES = %i[SILVER GOLD].freeze
  # @!endgroup

  # Runs the entire advent calendar and prints solutions to console.
  #
  # @return [void]
  def self.solve!
    DATE_RANGE.each do |date|
      PUZZLE_TYPES.each do |type|
        SolutionMessage.print(const_get(PUZZLE % {date: date.strftime('%B%d'), type: type}))
      end
    end

    exit 0
  end

end
