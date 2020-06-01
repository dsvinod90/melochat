Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  get 'welcome/home', to: 'welcome#home'
  root 'welcome#home'
  resources :blogs
end
