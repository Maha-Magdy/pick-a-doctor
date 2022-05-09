Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, default: {format: :json} do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :specializations, only: [:index, :show, :create, :update, :destroy] do
      resources :doctors, only: [:index, :show, :create, :update, :destroy]
    end
    
    resources :appointments
    get '/user_appointments', to: 'appointments#user_appointments'
    get '/doctor_appointments', to: 'appointments#doctor_appointments'
    
  end
  # Defines the root path route ("/")
  # root "articles#index"
end