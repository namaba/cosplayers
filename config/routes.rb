Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks:  "omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  resources :creaters do
    resources :requests, module: :creaters do
      get :thank, on: :collection
      member do
        get :accept, :decline, :complete
      end
    end
  end
  resources :requesters, only: %i[index show]
  resources :photos
  resources :users do
    get :download
    post :pay, :creditcard, on: :collection
  end
end
