Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: [:create, :index, :update, :new, :show] do
    resources :comments, only: [:create, :update, :new, :show, :destroy]
  end
  resources :teams, only: [:index, :show]
  get "dashboard", to: "dashboards#dashboard", as: :dashboard
end
