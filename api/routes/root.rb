# frozen_string_literal: true

require 'grape'
require_relative '../exceptions/http_exception'
require_relative '../exceptions/validation_exception'
require_relative '../exceptions/bad_request_exception'
require_relative '../exceptions/unauthorized_exception'
require_relative '../helpers/container_helper'
require_relative '../helpers/jsender_formatter'
require_relative '../helpers/oauth2_helper'
require_relative 'v1/root'

module Routes
  # Root endpoint
  class Root < Grape::API
    format :json
    formatter :json, JSenderFormatter::Success
    error_formatter :json, JSenderFormatter::Error
    helpers ContainerHelper
    helpers OAuth2Helper

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!(e.errors, 400)
    end

    rescue_from ::Exceptions::ValidationException do |e|
      error!({ message: e.message, errors: e.errors.to_h }, e.code)
    end

    rescue_from ::Exceptions::HttpException do |e|
      error!(e.message.strip, e.code)
    end

    rescue_from StandardError do |e|
      error_message = e.message
      error_message = "[#{e.message}] -> [#{e.backtrace}]" unless resolve(:production?)
      log.error(error_message)
      error!("Something went wrong [#{e.message}]", 500)
    end

    get :health_check do
      { message: 'healthy' }
    end

    mount V1::Root
  end
end
