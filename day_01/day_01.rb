require_relative 'input'

module AdventOfCode
  class Day1
    include Input

    # Silver Star
    # @return 484
    def sum_frequency_changes!
      FREQUENCY_CHANGES.sum(INITIAL_FREQUENCY)
    end

    # Gold Star
    # @return 367
    # @todo   This whole thing is a runtime disaster.  Works but needs to bmcvk
    def find_repeated_frequency!(frequencies: [INITIAL_FREQUENCY])
      time = Time.now
      FREQUENCY_CHANGES.each do |change|

        new_freq = frequencies.last + change

        frequencies.push(new_freq)

        # arr.find { |e| arr.index(e) != arr.rindex(e) }

        return new_freq unless frequencies.length == frequencies.uniq.length
        #frequencies.index(new_freq) == frequencies.rindex(new_freq)
      end
      # FREQUENCY_CHANGES.each { |change| frequencies.push(frequencies.last + change) }
      # frequencies.each       { |el| return el unless frequencies.index(el) == frequencies.rindex(el) }
      puts "Time for one cycle: #{Time.now - time}"
      find_repeated_frequency!(frequencies: frequencies)
      puts "Time for full cycle: #{Time.now - time}"
    end
  end
end


Day1.new.sum_frequency_changes!sum_frequency_changes!
