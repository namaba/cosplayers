Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks:  "omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  resources :creaters, only: %i[index show] do
    resources :requests, module: :creaters do
      get :thank, on: :collection
    end
  end
  resources :requesters, only: %i[index show]
  resources :photos
  resources :users
end
