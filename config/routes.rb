Rails.application.routes.draw do
  devise_for :users
  root to: "profiles#index"
  resources :profiles, except: [:index] do
    resources :sounds do
      resources :comments, only: [:create, :destroy]
    end
  end
end
