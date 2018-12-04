# frozen_string_literal: true

require_relative '../inputs/december_02_input.rb'

module AdventOfCode
  module Days
    class December02 < Day
      include AdventOfCode::Inputs::December02Input

      # Solves the December 2nd Silver Puzzle
      #
      # @return [Integer<6888>] the checksum of all given ids
      def self.calculate_checksum!
        BOX_IDS
          .flat_map { |id| id.chars.map(&id.method(:count)) & [2, 3] }
          .partition(&:even?)
          .map(&:size)
          .reduce(:*)
      end

      SILVER_PUZZLE = {
        answer:     :calculate_checksum!,
        class_name: :December02,
        date:       DATE,
        message:    'The resulting checksum is',
        type:       :SILVER
      }

      # Solves the December 2nd Gold Puzzle
      #
      # @return [String<icxjvbrobtunlelzpdmfkahgs>] the string of characters shared by the two ids
      def self.find_similar_id_pair!
        # BOX_IDS.group_by(&:sum).tap do |hash|
        BOX_IDS.dup.tap do |ids|
          until ids.empty?
            id = ids.pop
            # hash.slice(*(checksum..(checksum + MAX_CHECKSUM_SEPARATION))).each do |(match_checksum, match_ids)|
            ids.each do |match_id|
            # match_ids.each do |match_id|
              match_chars = match_id.chars
              match       = id.chars.map.with_index { |c, i| c if match_chars[i] == c }.join

              return match if match.length == ID_LENGTH - 1
            end
          end
        end
      end

      GOLD_PUZZLE = {
        answer:     :find_similar_id_pair!,
        class_name: :December02,
        date:       DATE,
        message:    'The characters shared by the ids are',
        type:       :GOLD
      }

    end
  end
end
