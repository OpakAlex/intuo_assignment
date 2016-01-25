Rails.application.routes.draw do
  match '*all', to: 'application#cors_preflight_check', via: :options

  namespace :api do
    namespace :v1 do
      post "/users/sign_in", to: "sessions#create"
      post "/users/create", to: "users#create"
      delete "/users", to: "sessions#destroy"

      resources :movies, only: [:show, :index, :create]
    end
  end
end
