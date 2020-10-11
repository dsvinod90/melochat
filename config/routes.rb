# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations', passwords: 'admins/passwords' }
  root 'welcome#index'
  resources :welcome, only: [:index] do
    collection do
      get 'random_number_trivia'
      get 'random_date_trivia'
    end
  end
  resources :covid_updates, only: [:index] do
    collection do
      get 'country_summary'
      get 'global_summary'
      get 'date_wise_country_summary'
    end
  end
  resources :blogs do
    resources :comments
  end
  resources :explores, only: [:index] do
    collection do
      get 'charts'
      get 'artists'
      get 'show_artists'
      get 'trending'
    end
  end
  resources :users
  get 'users/:token/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
  put 'users/:token/unsubscribe_user', to: 'users#unsubscribe_user', as: 'unsubscribe_user'
  get 'space/apod', to: 'space#apod'
  get 'space/asteroid_news', to: 'space#asteroid_news'
  get 'space/astronauts_data', to: 'space#astronauts_data'
  resources :admins do
    collection do
      get 'show_admins_list'
      get 'show_users_list'
      get 'newsletter_settings'
      get 'send_newsletters'
    end
  end
  resources :sendgrid_templates
end
