# frozen_string_literal: true

module AdventOfCode
  require 'date'

  require_relative 'advent_of_code/completion_message'
  require_relative 'advent_of_code/days'

  START_DATE = Date.parse('2018-12-01').freeze
  END_DATE   = Date.parse('2018-12-01').freeze
  DATE_RANGE = (START_DATE..END_DATE).freeze

  PUZZLE_TYPES = %i[SILVER GOLD]

  PUZZLE = "AdventOfCode::Days::%{date}::%{type}_PUZZLE"

  def self.solve!
    DATE_RANGE.each do |date|
      PUZZLE_TYPES.each do |type|
        CompletionMessage.new(const_get(PUZZLE % {date: date.strftime('%B%d'), type: type}))
      end
    end
  end

end
