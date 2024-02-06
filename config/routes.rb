Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :cocktails do
        collection do
          get :index
        end
        member do
          get :show
        end
      end
    end
  end
end
