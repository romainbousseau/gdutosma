Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :products do
    get 'undisplay', to: "products#undisplay"
    resources :rents
  end
  resources :users, only: [ :edit, :update, :show ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  patch 'products/:product_id/rents/:id', to: 'rents#validate', as: :validate
end
