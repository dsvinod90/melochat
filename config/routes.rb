Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations', passwords: 'admins/passwords' }
  root 'welcome#index'
  resources :welcome, only: [:index] do
    collection do
      get 'home'
    end
  end
  get 'space/apod', to: 'space#apod'
  resources :covid_updates, only: [:index] do
    collection do
      get 'country_summary'
      get 'global_summary'
      get 'date_wise_country_summary'
    end
  end
  resources :blogs
end
