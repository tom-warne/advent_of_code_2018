# frozen_string_literal: true

class CompletionMessage

    # Colors
    GRAY   = "\e[37m"
    GREEN  = "\e[32m"
    RED    = "\e[31m"
    YELLOW = "\e[33m"
    END_C  = "\e[m"

    # Components
    ANSWER  = "#{GREEN}%{answer}#{END_C}"
    DATE    = "#{RED}%{date} (#{END_C}"
    MESSAGE = "#{RED}): %{message}#{END_C}"
    TYPES   = {
                GOLD:   "#{YELLOW} Gold #{END_C}",
                SILVER: "#{GRAY}Silver#{END_C}"
              }

    RESULT = "#{DATE}%{type}#{MESSAGE} #{ANSWER}"

    def initialize(answer:, date:, message:, type:)
      puts RESULT % {
        answer:  answer,
        date:    date.strftime('%B %d'),
        message: message,
        type:    TYPES[type]
      }
    end


end
