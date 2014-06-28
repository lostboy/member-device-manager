require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config

  authenticate :user, ->(user) { Ability.new(user).can? :read, :sidekiq } do
    mount Sidekiq::Web => '/sidekiq'
  end

  ActiveAdmin.routes self
end
