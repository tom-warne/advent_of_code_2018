# frozen_string_literal: true

require_relative '../inputs/december_04_input'

module AdventOfCode
  module Days
    class December04 < Day
      include AdventOfCode::Inputs::December04Input

      class << self

        # Marker for storing which guard we are working with.
        @@active_guard = nil

        # Solves the December 4th Silver Puzzle
        #
        # @param  sort_method [Symbol] method for sorting the initial parsed input
        # @return [Integer<11367>] id of sleepiest guard * minute most often asleep
        def determine_sleepiest_guard!(sort_method: :sum)
          PARSED_INPUT
            .sort_by { |_, sleep_times| sleep_times.values.public_send(sort_method) }
            .last
            .each_cons(2)
            .map { |(guard, sleep_count)| guard * sleep_count.invert.sort.last.last }
            .first
        end

        # Solves the December 4th Gold Puzzle
        #
        # @return [Int<36896>] id of most consistant sleeping guard * most likely time of sleep
        def find_most_common_time_to_sleep!
          determine_sleepiest_guard!(sort_method: :max)
        end
      end

      SILVER_PUZZLE = {
        answer:     :determine_sleepiest_guard!,
        class_name: :December04,
        date:       formatted_date,
        message:    'The sleepiest guard id * the minute most often asleep:',
        type:       :SILVER
      }.freeze

      GOLD_PUZZLE = {
        answer:     :find_most_common_time_to_sleep!,
        class_name: :December04,
        date:       formatted_date,
        message:    'The guard id * the minute most slept on:',
        type:       :GOLD
      }.freeze

      private

      # @!group Private Constants
      # One minute expressed as a fraction of a day
      #
      MINUTE_STEP = 1.to_f / (24 * 60)

      # Sorts the data by DateTime with a corresponding action
      #
      SORTED_INPUT =
        SLEEP_SCHEDULES
          .split("\n")
          .sort
          .map { |datum| [DateTime.parse(datum.scan(/\[.+\]/).first), datum.sub($&, '')] }
          .freeze

      # Formats the input data into a count of how many
      # times a guard is asleep at any given time
      #
      PARSED_INPUT =
        COUNTING_HASH_2D.dup.tap do |sleep_schedules|
          SORTED_INPUT.each.with_index(1) do |(date, action), index|
            case action
            when /Guard/
              @@active_guard = action.scan(/\d+/).first.to_i
            when /falls asleep/
              date.step(SORTED_INPUT[index].first - MINUTE_STEP, MINUTE_STEP) do |minute|
                sleep_schedules[@@active_guard][minute.strftime('%H%M').to_i] += 1
              end
            end
          end
        end

      private_constant :MINUTE_STEP
      private_constant :SORTED_INPUT
      private_constant :PARSED_INPUT
      # @!endgroup
    end
  end
end
