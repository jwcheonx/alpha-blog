Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', :as => :rails_health_check

  root 'pages#home'
  get 'about' => 'pages#about'

  resources :articles do
    collection do
      get 'trashed', action: :list_trashed
    end

    member do
      patch 'restore'
    end

    resources :comments, only: %i[create destroy]
  end

  resources :categories, only: %i[index show new edit create update]

  get 'signup' => 'users#new'
  resources :users, except: :new

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
