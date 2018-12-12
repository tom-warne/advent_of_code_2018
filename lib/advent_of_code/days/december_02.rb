# frozen_string_literal: true

require_relative '../inputs/december_02_input'

module AdventOfCode
  module Days
    class December02 < Day
      class << self
        include AdventOfCode::Inputs::December02Input

        # Solves the December 2nd Silver Puzzle
        #
        # @return [Integer<6888>] the checksum of all given ids
        def calculate_checksum!
          BOX_IDS
            .flat_map { |id| id.chars.map(&id.method(:count)) & [2, 3] }
            .partition(&:even?)
            .map(&:size)
            .reduce(:*)
        end

        # Solves the December 2nd Gold Puzzle
        #
        # @return [String<icxjvbrobtunlelzpdmfkahgs>] the string of characters shared by the two ids
        def find_similar_id_pair!
          BOX_IDS.dup.tap do |ids|
            until ids.empty?
              id = ids.pop
              ids.each do |match_id|
                match_chars = match_id.chars
                match       = id.chars.map.with_index { |c, i| c if match_chars[i] == c }.join

                return match if match.length == ID_LENGTH - 1
              end
            end
          end
        end
      end

      SILVER_PUZZLE = {
        answer:     :calculate_checksum!,
        class_name: :December02,
        date:       formatted_date,
        message:    'The resulting checksum:',
        type:       :SILVER
      }.freeze

      GOLD_PUZZLE = {
        answer:     :find_similar_id_pair!,
        class_name: :December02,
        date:       formatted_date,
        message:    'The characters shared by the ids:',
        type:       :GOLD
      }.freeze
    end
  end
end
