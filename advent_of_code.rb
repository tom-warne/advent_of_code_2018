# Each day as the main file is built it will automatically be incorporated
#  into the requirements.  -TW
Dir.glob('**/').each { |dir| require_relative "#{dir}#{dir.chomp('/')}" }

class AdventOfCode
  def initialize
    print_calendar!
  end

  def print_calendar
  end
end
