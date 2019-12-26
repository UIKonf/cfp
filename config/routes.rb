Rails.application.routes.draw do
  root 'welcome#index'

  # Authentication and session management
  get '/login', to: 'github_authentication#new'
  get '/auth/github/callback', to: 'github_authentication#callback'
  get '/auth/failure', to: 'github_authentication#failure'
  delete '/logout', to: 'github_authentication#logout'

  resources :users, only: [:show] do
    resources :selections, only: %i[index create destroy]
  end

  resources :proposals do
    resources :comments, only: %i[index create destroy]

    member do
      post :publish
      post :withdraw
    end
  end
end
