Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  # 作品の新規登録、編集、削除用
  namespace :creater do
    resources :works
    resources :photos, only: %i[ edit update destroy]
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
  # 一般ユーザーの閲覧用
  resources :photos, only: %i[index show]
  resources :users do
    get :download
  end
  namespace :user do
    resources :requests
  end
  resources :credit_cards
end
