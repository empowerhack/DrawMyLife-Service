Rails.application.routes.draw do
  devise_for :users, path_prefix: 'my', controllers: {
    sessions: 'profiles/sessions',
    confirmations: 'profiles/confirmations',
    passwords: 'profiles/passwords'
  }

  devise_scope :user do
    get 'my/users/edit' => 'profiles/registrations#edit', as: 'edit_user_registration'
    put 'my/users' => 'profiles/registrations#update', as: 'user_registration'
    delete 'my/users' => 'profiles/registrations#destroy'
    patch 'my/users/confirmation' => 'profiles/confirmations#update', via: :patch, as: :update_user_confirmation
  end

  resources :users do
    put :deactivate
    put :reactivate
  end

  resources :drawings, :organisations

  get 'hxlstats', to: 'hxlstats#show'

  root 'drawings#index'

  namespace :api, defaults: { format: :hal } do
    resources :drawings
  end
end
