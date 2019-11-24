Rails.application.routes.draw do
  get 'welcome/index'

  resources :proposals

  root 'welcome#index'
end
