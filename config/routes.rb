Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :products do
    resources :rents
  end
  resources :users, only: [ :edit, :update, :show ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
