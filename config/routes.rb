require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes self

  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#dashboard'
  resources :members, only: %i(index show update)

  namespace 'devices' do
    resources :types, only: %i(index)
  end
end
