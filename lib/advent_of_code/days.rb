module AdventOfCode
  module Days
    require_relative 'days/day'

    Dir[File.join(__dir__, 'days', 'december_*.rb')].each { |file| require file }
  end
end
