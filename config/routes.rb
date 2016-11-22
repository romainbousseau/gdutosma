Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :products do
    get 'undisplay', to: "products#undisplay"
  end
  resources :users, only: [ :edit, :update, :show ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
