# frozen_string_literal: true

require 'grape'

module Routes
  module V1
    # Root v1 endpoint
    class Root < Grape::API
      version 'v1'

      # v1 routes are mounted here
    end
  end
end
