# frozen_string_literal: true

require 'rack/cors'
require_relative 'api/boot'

use Rack::Cors do
  config = Container.resolve(:config)
  allowed_origins = config.application.dig('cors', 'allowed_origins').split(',').map(&:strip)
  allowed_origins.to_a.each do |origin|
    allow do
      origins origin
      resource '*', headers: :any, methods: %i[get post put patch delete options]
    end
  end
end

run Routes::Root
