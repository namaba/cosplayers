Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  resources :artists, only: %i[index show]
  resources :requesters, only: %i[index show]
  resources :photos
end
