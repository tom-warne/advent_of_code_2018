# frozen_string_literal: true

# @author Tom Warne <thomaswarne@gmail.com>
module AdventOfCode
  require 'date'

  require_relative 'advent_of_code/puzzle_response'
  require_relative 'advent_of_code/solution_message'
  require_relative 'advent_of_code/days'

  # @!group Date Config
  #
  START_DATE           = Date.parse('2018-12-01').freeze
  END_DATE             = Date.parse('2018-12-06').freeze
  DATE_RANGE           = (START_DATE..END_DATE).freeze
  FORMATTED_DATE_RANGE = DATE_RANGE.map { |date| date.strftime('%d') }

  # @!group Puzzle Config
  #
  PUZZLE       = "AdventOfCode::Days::December%{day}::%{type}_PUZZLE"
  PUZZLE_TYPES = %i[SILVER GOLD].freeze
  # @!endgroup

  # Runs the entire advent calendar and prints solutions to console.
  #
  # @return [void]
  def self.solve!(days: FORMATTED_DATE_RANGE, types: PUZZLE_TYPES)
    days.each do |day|
      types.each do |type|
        SolutionMessage.print(const_get(PUZZLE % {day: '%02i' % day, type: type}))
      end
    end

    exit 0
  end

end
