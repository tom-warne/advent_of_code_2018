module AdventOfCode
  module Days
    Dir.glob(File.expand_path('days/**', __dir__)).each { |file| require "#{file}"}
  end
end
