Rails.application.routes.draw do
  get 'github_authentication/callback'
  get 'github_authentication/logout'
  root 'welcome#index'

  resources :users

  # Authentication and session management
  get '/login', to: 'github_authentication#new'
  get '/auth/github/callback', to: 'github_authentication#callback'
  get '/auth/failure', to: 'github_authentication#failure'
  delete '/logout', to: 'github_authentication#logout'

  resources :proposals do
    resources :comments
  end

end
