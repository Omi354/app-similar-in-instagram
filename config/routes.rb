require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "posts#index"
  resource :profile, only: [:show, :edit, :update]
  resource :following, only: [:index]
  resource :follower, only: [:index]

  resources :accounts, only: [:show] do
    resource :follow, only: [:create, :show]
    resource :unfollow, only: [:create]
  end

  resources :posts, only: [:new, :create, :index, :show] do
    resource :like, only: [:create, :destroy, :show]
    resources :comments, only: [:create, :index]
  end

end
