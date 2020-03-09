Rails.application.routes.draw do
  root 'users#index'
  resources :users do
    collection do
      resource :search, only: %i[show]
    end
  end
  resource :authentication, only: %i[new create destroy]
  get 'home', to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
