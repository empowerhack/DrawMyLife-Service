Rails.application.routes.draw do
  devise_for :users, path_prefix: 'my', controllers: { registrations: 'registrations' }
  resources :users

  resources :drawings, :organisations

  root 'drawings#index'
end
