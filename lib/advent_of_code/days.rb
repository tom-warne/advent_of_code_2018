module AdventOfCode
  module Days
    require_relative 'days/day'

    Dir.glob(File.expand_path('days/december_*.*', __dir__)).each { |file| require "#{file}"}
  end
end
