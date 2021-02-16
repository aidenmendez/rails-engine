Rails.application.routes.draw do
  # module :API do
  #   module :V1 do
  #     resource :merchants, only: [:index]
  #   end
  # end

  # get '/api/v1/merchants', to: 'merchants#show'

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
    end
  end
end
