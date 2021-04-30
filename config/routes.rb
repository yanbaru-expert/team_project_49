Rails.application.routes.draw do
  devise_for :users
  root 'texts#index'
  resources :texts
end
