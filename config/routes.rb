Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "posts#index"
  resource :profile, only: [:show, :edit, :update]

  resources :posts, only: [:new, :create, :index, :show] do
    resource :like, only: [:create, :destroy, :show]
    resources :comments, only: [:create, :index]
  end
end
