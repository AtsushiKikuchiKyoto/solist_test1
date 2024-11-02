Rails.application.routes.draw do
  devise_for :users
  root to: "profiles#index"
  get 'profiles/switch'
  resources :profiles
  resources :sounds, only: [:new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
end
