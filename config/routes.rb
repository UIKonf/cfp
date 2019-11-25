Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: 'users#new'

  resources :proposals do
    resources :comments
  end

end
