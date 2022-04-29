Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, default: {format: :json} do
    resources :doctors, only: [:index, :show, :create, :update, :destroy]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
