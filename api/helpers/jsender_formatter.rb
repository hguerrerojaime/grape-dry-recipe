# frozen_string_literal: true

require 'jsender'

module JSenderFormatter
  # Success Formatter
  module Success
    def self.call(object, _env)
      Jsender::Json.success(data: object)
    end
  end
  # Error Formatter
  module Error
    def self.call(message, _backtrace, _options, _env, _foo)
      if message.is_a?(Hash)
        Jsender::Json.failure(data: message)
      else
        Jsender::Json.error(message: message)
      end
    end
  end
end
