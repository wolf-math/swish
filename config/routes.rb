Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: [:create, :index, :update, :new, :show] do
    resources :comments, only: [:create, :update, :new, :show, :destroy]
  end
  # Comments on a comment
  resources :comments do
    resources :comments, only: [:create]
  end

  resources :teams, only: [:index, :show]
  resources :follows, only: [:new, :create, :update, :show]
  resources :people, only: [:index, :show]
  resources :games, only: [:index, :show]

  resources :users do
    get :follow
    get :unfollow
  end

  get "dashboard", to: "dashboards#dashboard", as: :dashboard
end
