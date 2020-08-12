Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations', passwords: 'admins/passwords' }
  root 'welcome#index'
  resources :welcome, only: [:index] do
    collection do
      get 'home'
    end
  end
  resources :covid_updates, only: [:index] do
    collection do
      get 'country_summary'
      get 'global_summary'
      get 'date_wise_country_summary'
    end
  end
  resources :blogs
  get 'space/apod', to: 'space#apod'
  get 'space/asteroid_news', to: 'space#asteroid_news'
  get 'space/astronauts_data', to: 'space#astronauts_data'
end
