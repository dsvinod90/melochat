Rails.application.routes.draw do
  get 'welcome/home', to: 'welcome#home'
  root 'welcome#home'
  resources :blogs
end
