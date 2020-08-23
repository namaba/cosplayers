Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  resources :artists, only: %i[index show]
  resources :requesters, only: %i[index show]
  resources :photos
  resources :users
  resources :requests do
    get :thank, on: :collection
  end
end
