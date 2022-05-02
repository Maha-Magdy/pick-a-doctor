Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :specializations, path: '/api/specializations'
  mount Rswag::Api::Engine => "api-docs"
  mount Rswag::Ui::Engine => "api-docs"

end