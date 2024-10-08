require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "posts#index"
  resource :timeline, only: [:show]
  resource :profile, only: [:show, :edit, :update]

  resources :posts, only: [:new, :create, :index, :show]
  resources :accounts, only: [:show] do
    resource :following, only: [:show]
    resource :follower, only: [:show]
  end


  namespace :api ,defaults: { format: :json } do
    scope '/accounts/:account_id' do
      resource :follow, only: [:create, :show]
      resource :unfollow, only: [:create]
    end

    scope '/posts/:post_id' do
      resource :like, only: [:create, :destroy, :show]
      resources :comments, only: [:create, :index]
    end

  end

end
