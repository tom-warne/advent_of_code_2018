module AdventOfCode
  module Inputs
    Dir[File.join(__dir__, 'days', 'december_*_input.rb')].each { |file| require file }
  end
end
