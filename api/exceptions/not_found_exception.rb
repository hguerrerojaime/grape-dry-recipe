# frozen_string_literal: true

require_relative 'http_exception'

module Exceptions
  # Custom exception that should be call when resource is not found
  class NotFoundException < HttpException
    attr_reader :code, :errors

    def initialize(message)
      super(message, 404)
    end
  end
end
