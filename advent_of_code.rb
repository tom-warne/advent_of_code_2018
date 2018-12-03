# frozen_string_literal: true

require 'date'

require_relative 'completion_message'

# Each day when the main file is created it will automatically
# be incorporated into the requirements.  -TW
#
Dir.glob('**/').each { |dir| require_relative "#{dir}#{dir.chomp('/')}" }

class AdventOfCode
  START_DATE = Date.parse('2018-12-01').freeze
  END_DATE   = Date.parse('2018-12-01').freeze
  DATE_RANGE = (START_DATE..END_DATE).freeze

  TYPES = %i[GOLD SILVER].freeze

  def self.solve!
    DATE_RANGE.each do |date|
      TYPES.each do |type|
        CompletionMessage.new(const_get "AdventOfCode::#{date.strftime('%B%d')}::#{TYPE}_PUZZLE")
      end
    end
  end

end
