# frozen_string_literal: true

if Rails.env.development?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3001'
      resource '*', headers: :any, methods: [:get]
    end
  end
end
