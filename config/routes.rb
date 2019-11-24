Rails.application.routes.draw do
  get 'welcome/index'

  resources :proposals do
    resources :comments
  end

  root 'welcome#index'
end
