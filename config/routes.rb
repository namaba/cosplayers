Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  namespace :creater do
    resources :works
  end
  resources :creaters do
    resources :works, module: :creaters
    resources :requests, module: :creaters do
      member do
        get :accept, :decline, :complete, :thank
      end
    end
  end
  resources :bills
  resources :requesters, only: %i[index show]
  resources :photos
  resources :users do
    get :download
  end
  namespace :user do
    resources :requests
  end
  resources :credit_cards
end
