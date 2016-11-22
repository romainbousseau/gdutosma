Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  resources :users, only: [ :edit, :update, :show ]
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :products do
    resources :rents, only: [:show, :new, :create]
    get 'undisplay', to: "products#undisplay"
    get 'unavailable', to: "products#unavailable"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'rents/:id/validate', to: 'rents#validate', as: :validate
  get 'rents/:id/decline', to: 'rents#decline', as: :decline
  get 'rents/:id/done', to: 'done#decline', as: :done
end
