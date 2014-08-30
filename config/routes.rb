require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticate :admin_user, ->(user) { Ability.new(user).can? :read, :sidekiq } do
    mount Sidekiq::Web => '/sidekiq'
  end

  ActiveAdmin.routes self

  resources :users, only: %i(index)
end
