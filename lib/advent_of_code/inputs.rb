module AdventOfCode
  module Inputs
    Dir.glob(File.expand_path('inputs/**', __dir__)).each { |file| require "#{file}"}
  end
end
