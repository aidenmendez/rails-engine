Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope module: :items do
        get "items/find", to: "search#find"
      end

      scope module: :merchants do
        get "merchants/find_all", to: "search#find_all"
        get "merchants/most_items", to: "merchants#most_items"
      end
      
      resources :items, module: :items, only: [:index, :show, :create, :destroy, :update] do
        resources :merchant, only: [:index]
      end

      resources :merchants, module: :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
    end
  end
end
