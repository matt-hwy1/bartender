# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get 'search', to: 'cocktails#index'
    get 'detail', to: 'cocktails#show'
    get 'count', to: 'cocktails#count'
  end
end
