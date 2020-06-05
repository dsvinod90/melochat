Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations', passwords: 'admins/passwords' }
  get 'welcome/home', to: 'welcome#home'
  root 'welcome#home'
  resources :blogs
end
