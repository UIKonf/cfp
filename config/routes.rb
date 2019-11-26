Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: 'users#new'

  resources :users

  resources :proposals do
    resources :comments
  end

end
