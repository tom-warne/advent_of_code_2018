# frozen_string_literal: true

require_relative '../inputs/december_04_input.rb'

module AdventOfCode
  module Days
    class December04 < Day
      include AdventOfCode::Inputs::December04Input

      # Marker for storing which guard we are working with.
      @@active_guard = nil

      # One minute expressed as a fraction of a day.
      MINUTE_STEP = 1.to_f / (24 * 60)

      # Solves the December 4th Silver Puzzle
      #
      # @return [Integer<11367>] id of guard * minute most often asleep
      def self.determine_sleepiest_guard!
        parse_input!
          .sort_by { |_, sleep_times| sleep_times.values.sum }
          .last
          .tap { |(guard, sleep_count)|
            return guard * sleep_count.invert.sort.last.last
          }
      end

      SILVER_PUZZLE = {
        answer:     :determine_sleepiest_guard!,
        class_name: :December04,
        date:       DATE,
        message:    'The guard id * the minute most often asleep:',
        type:       :SILVER
      }

      # Solves the December 4th Gold Puzzle
      #
      # @return [String<>] ??
      def self.tbd_gold!
      end

      GOLD_PUZZLE = {
        answer:     :tbd_gold!,
        class_name: :December04,
        date:       DATE,
        message:    ':',
        type:       :GOLD
      }

      private

      # Formats the input data into a count of how many times a guard is asleep at any given time
      # @todo Look into using a struct here -TW
      #
      # @private
      # @return [Hash<String, Hash<String, Int>>] {guard_id => {HHMM => count(sleep)}}
      def self.parse_input!
        Hash
          .new { |h, k| h[k] = Hash.new(0) }
          .tap do |sleep_schedules|
            sorted_input.each.with_index(1) do |(date, action), index|
              case action
              when /Guard/
                @@active_guard = action.scan(/\d+/).first.to_i
              when /falls asleep/
                date.step(sorted_input[index].first - MINUTE_STEP, MINUTE_STEP) do |minute|
                  sleep_schedules[@@active_guard][minute.strftime('%H%M').to_i] += 1
                end
              end
            end
          end
      end

      # Formats the input data into a usable form sorted chronologically
      #
      # @private
      # @return [Array<DateTime,String>] array of dates and actions performed
      def self.sorted_input
        SLEEP_SCHEDULES
          .split("\n")
          .sort
          .map { |datum| [DateTime.parse(datum.scan(/\[.+\]/).first), datum.sub($&, '')] }
      end

    end
  end
end
