Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  resources :profiles, only: [:new, :create]

  resources :reports, only: [:index]

  get '/reports/external', to: 'reports#reports_external'
end
