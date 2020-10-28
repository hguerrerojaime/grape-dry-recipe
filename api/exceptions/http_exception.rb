# frozen_string_literal: true

module Exceptions
  # Base Http Error class
  class HttpException < StandardError
    attr_reader :code

    def initialize(message, code)
      super(message)
      @code = code
    end
  end
end
