# frozen_string_literal: true

require_relative 'http_exception'

module Exceptions
  # Http custom error to handle Validations
  class ValidationException < HttpException
    attr_reader :code, :errors

    def initialize(message, errors = {}, code = 400)
      super(message, code)
      @errors = errors
    end
  end
end
