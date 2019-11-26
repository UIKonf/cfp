Rails.application.routes.draw do
  get 'github_authentication/callback'
  get 'github_authentication/logout'
  root 'welcome#index'

  get '/login', to: 'users#new'

  resources :users

  get '/auth/github/callback', to: 'github_authentication#callback'
  get '/logout', to: 'github_authentication#logout'

  resources :proposals do
    resources :comments
  end

end
