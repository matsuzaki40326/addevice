Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  get 'search' => 'searches#search', as: 'search'
  resources :users, only: [:index, :show, :edit, :update] do
    member do
     get :favorites
    end
  end
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :reviews, only: [:create, :edit, :update, :destroy] do
      resource :goods, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
