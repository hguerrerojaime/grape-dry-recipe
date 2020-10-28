# frozen_string_literal: true

require_relative 'http_exception'

module Exceptions
  # Custom exception that should be call when request is invalid
  class BadRequestException < HttpException
    attr_reader :code, :errors

    def initialize(message)
      super(message, 400)
    end
  end
end
