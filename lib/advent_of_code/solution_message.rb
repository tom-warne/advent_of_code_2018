# frozen_string_literal: true

module AdventOfCode

  # The SolutionMessage is responsible for receiving a {PuzzleResponse} from a
  # completed puzzle and rendering the data into a string for display
  # in the terminal.
  class SolutionMessage

    # @!group Colors
    GRAY   = "\e[37m"
    GREEN  = "\e[32m"
    RED    = "\e[31m"
    YELLOW = "\e[33m"
    END_C  = "\e[m"

    # @!group Components
    ANSWER  = "#{GREEN}%{answer}#{END_C}"
    DATE    = "#{RED}%{date} (#{END_C}"
    MESSAGE = "#{RED}): %{message}#{END_C}"
    TYPES   = {
                GOLD:   "#{YELLOW} Gold #{END_C}",
                SILVER: "#{GRAY}Silver#{END_C}"
              }.freeze

    RESULT  = "#{DATE}%{type}#{MESSAGE} #{ANSWER}"
    # @!endgroup

    # Fetches {Day} puzzle solution data, applies formats, and prints to terminal
    #
    # @param  answer     [Symbol] puzzle solution method to be run
    # @param  class_name [Symbol]
    # @param  date       [Date]
    # @param  message    [String] to be formatted and printed to terminal
    # @param  type       [Symbol] (:GOLD, :SILVER)
    # @return [void]
    def self.print(answer:, class_name:, date:, message:, type:)
      puts RESULT % {
        answer:  const_get("AdventOfCode::Days::#{class_name}").public_send(answer),
        date:    date.strftime('%B %d'),
        message: message,
        type:    TYPES[type]
      }
    end
  end
end
