Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants, module: :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end

      resources :items, module: :items, only: [:index, :show]
    end
  end

end
