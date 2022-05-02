Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, default: {format: :json} do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :doctors, only: [:index, :show, :create, :update, :destroy]
    resources :specializations
  end
  # Defines the root path route ("/")
  # root "articles#index"
end