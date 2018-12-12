# frozen_string_literal: true

require_relative '../inputs/december_06_input.rb'

module AdventOfCode
  module Days
    class December06 < Day
      include AdventOfCode::Inputs::December06Input
      class << self

        # Solves the December 6th Silver Puzzle
        #
        # @return [Integer<5626>] area surronding most isolated point
        def find_size_of_area_around_most_isolated_initial_point!
          Grid.new
            .populate!
            .map_territories!
            .largest_territory
        end

        # Solves the December 6th Gold Puzzle
        #
        # @return [?<>] ??
        def tbd_gold!
        end
      end

      SILVER_PUZZLE = {
        answer:     :find_size_of_area_around_most_isolated_initial_point!,
        class_name: :December06,
        date:       formatted_date,
        message:    'Size of area surronding the most isolated initial point:',
        type:       :SILVER
      }

      GOLD_PUZZLE = {
        answer:     :tbd_gold!,
        class_name: :December06,
        date:       formatted_date,
        message:    ':',
        type:       :GOLD
      }

      private

      # A grid's major attribute is the layout of the grid.  The layout is a
      # 2D Array where each element is a +Point+. Points are able to
      # interact with each other to change the state of the layout.
      # @todo In a real world scenario more of the attributes would be passed into #initialize.
      # @todo The individual elements and their logic should be moved to a +Point+ class.
      #
      # @note The grid is (316 x 294)
      # @note Grid is built and accessed via <tt>grid[y][x]</tt>
      # @see Struct
      class Grid
        attr_reader :layout, :territories

        def initialize
          @layout = rows { cols }
        end

        # @return [Integer] the largest territory on the {Grid}
        def largest_territory
          territories.values.max
        end

        # From each initial point begin mapping territory based on {MOVEMENTS}.
        # A +Point+ can claim territory, share territory, or be blocked.
        # The territories will continue to map until every Point is occupied.
        # @note Territories that touch the layout edge are Infinite by definition.
        #
        # @return [self] for chaining
        def map_territories!
          INITIAL_STEP.step(by: 1) do |current_step|
            active_points(current_step).each do |id:, step:, y:, x:|
              MOVEMENTS.each do |(Δx, Δy)|
                next_y, next_x = (y + Δy), (x + Δx)

                next unless [RANGE_Y.cover?(next_y), RANGE_X.cover?(next_x)].all?

                case next_point = point(next_y, next_x)
                when NilClass
                  set_next_point({id: id, step: current_step.next, y: next_y, x: next_x})
                when Hash
                  next if next_point[:id] == id

                  case next_point[:step] <=> current_step.next
                  when -1 then next
                  when 0  then next_point[:id] = ?.
                  end
                end

              end
            end
            return self if grid_is_full?
          end
        end

        # Insert an {INITIAL_POINT} into each element defined by {RELATIVE_COORDINATES}.
        # @see INITIAL_POINT
        # @see RELATIVE_COORDINATES
        # @return [self] for chaining
        def populate!
          RELATIVE_COORDINATES.each_with_index do |(x, y), index|
            @layout[y][x] = INITIAL_POINT.merge({id: index, y: y, x: x})
          end
          self
        end

        # @return [Array<Integer, Integer>] +Array<Point.id, count(Point.id)>+
        def territories
          @layout
            .flatten
            .select { |id:, **_| potential_largest_territory_ids.include?(id) }
            .each_with_object(Day::COUNTING_HASH.dup) { |point, memo| memo[point[:id]] += 1 }
        end

        private

        # Points with the most recent step are able to claim territory
        #
        # @param  current_step [Integer]
        # @return [Array<Point>]
        def active_points(current_step)
          @layout.flatten.compact.select { |point| point[:step] == current_step }
        end

        # List of all initial ids defining the unique territories
        #
        # @return [Array<Integer>]
        def all_point_ids
          STARTING_POINT_IDS
        end

        # @see    GRID_WIDTH
        # @return [Array<Point>]
        def cols
          Array.new(GRID_WIDTH) { nil }
        end

        # Any +Point+ that extends its territory to the edge of the layout will continue
        # on to have an infinite territory by definition. ∴ we can remove all of these
        # territories from the final consideration.
        #
        # @return [Array<Point>] points to be removed from consideration
        def edge_points
          @layout
            .flatten
            .select { |point| EDGES_X.include?(point[:x]) || EDGES_Y.include?(point[:y]) }
        end

        # @see edge_points
        # @return [Array<Integer>] ids of points to be removed from consideration
        def edge_point_ids
          edge_points.map { |point| point[:id] }.uniq
        end

        # @return [Boolean]
        def grid_is_full?
          @layout.flatten.count(nil).zero?
        end

        # @todo A lot of business logic becomes easier if +Point+ becomes a class.
        #
        # @param  y [Integer]
        # @param  x [Integer]
        # @return [Point]
        def point(y, x)
          @layout[y][x]
        end

        # @note memoized as this is a *very* costly operation
        # @return [Array<Point>] points with territories eligible for largest
        def potential_largest_territory_ids
          return @potential_largest_territory_ids if defined? @potential_largest_territory_ids
          @potential_largest_territory_ids = all_point_ids - edge_point_ids
        end

        # @param  block [Proc] the block used to build the columns(*cols*) in the row
        # @see    GRID_HEIGHT
        # @return [Array<{cols}>]
        def rows(&block)
          Array.new(GRID_HEIGHT, &block)
        end

        # @todo Another area for improvement by the creation of the +Point+ class
        # @param  params [Hash]
        # @option params [Integer] :id   (nil)
        # @option params [Integer] :step (0)
        # @option params [Integer] :y
        # @option params [Integer] :x
        # @return [Hash<Integer, Integer, Integer, Integer>] the next +Point+ of interest
        def set_next_point(params)
          @layout[params[:y]][params[:x]] = params
        end

        # @!group Transformation Properties
        #
        # @note ((42, 43), (358, 337))
        BOUNDING_CORNERS     = December06::COORDINATES.transpose.map(&:minmax).transpose.freeze
        OFFSET_X             = BOUNDING_CORNERS.first.first.freeze # @note 42
        OFFSET_Y             = BOUNDING_CORNERS.first.last.freeze  # @note 43
        private_constant :BOUNDING_CORNERS, :OFFSET_X, :OFFSET_Y

        # @!group Grid Properties
        RELATIVE_COORDINATES = December06::COORDINATES.map { |x, y| [x - OFFSET_X, y - OFFSET_Y] }.freeze
        STARTING_POINT_COUNT = RELATIVE_COORDINATES.count.freeze     # @note 50
        STARTING_POINT_IDS   = (0..STARTING_POINT_COUNT).to_a.freeze # @note (0..50).to_a

        # @note ((0, 0), (316, 294))
        CORNERS              = RELATIVE_COORDINATES.transpose.map(&:minmax).transpose.freeze
        UPPER_LEFT_CORNER    = CORNERS.first.freeze # @note (0, 0)
        LOWER_RIGHT_CORNER   = CORNERS.last.freeze  # @note (316, 294)

        RANGE_Y     = (UPPER_LEFT_CORNER.last..LOWER_RIGHT_CORNER.last).freeze   # @note (0..294)
        RANGE_X     = (UPPER_LEFT_CORNER.first..LOWER_RIGHT_CORNER.first).freeze # @note (0..316)
        EDGES_Y     = [RANGE_Y.begin, RANGE_Y.end].freeze # @note (0, 294)
        EDGES_X     = [RANGE_X.begin, RANGE_X.end].freeze # @note (0, 316)
        GRID_HEIGHT = RANGE_Y.size.freeze # @note 294
        GRID_WIDTH  = RANGE_X.size.freeze # @note 316
        private_constant :STARTING_POINT_COUNT, :STARTING_POINT_IDS
        private_constant :CORNERS, :UPPER_LEFT_CORNER, :LOWER_RIGHT_CORNER
        private_constant :RANGE_Y, :RANGE_X, :EDGES_Y, :EDGES_X, :GRID_HEIGHT, :GRID_WIDTH

        # @!group Point Properties
        INITIAL_ID    = 0
        INITIAL_STEP  = 0
        INITIAL_POINT = {id: INITIAL_ID, step: INITIAL_STEP, y: nil, x: nil}.freeze
        private_constant :INITIAL_ID, :INITIAL_STEP, :INITIAL_POINT

        # @!group Interaction Properties
        #
        # During each iteration a points influence can
        # advance one element in every direction.
        MOVEMENTS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze
        private_constant :MOVEMENTS
      end

    end
  end
end
