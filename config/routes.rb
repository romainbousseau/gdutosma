Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [ :edit, :update, :show ] do
    get 'dashboard', to: 'users#dashboard'
  end
  root to: 'pages#home'
  resources :products do
    resources :rents, only: [:show, :new, :create]
    resources :reviews, only: :create
    post 'undisplay', to: "products#undisplay"
    post 'change_availability', to: "products#change_availability"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rents, only: [] do
    member do
      post 'validate'
      post 'decline'
      post 'done'
    end
  end
end
