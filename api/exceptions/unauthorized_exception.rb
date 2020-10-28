# frozen_string_literal: true

require_relative 'http_exception'

module Exceptions
  # Custom exception that should be call when request is unauthorized
  class UnauthorizedException < HttpException
    attr_reader :code, :errors

    def initialize(message = 'unauthorized')
      super(message, 401)
    end
  end
end
