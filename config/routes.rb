Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callback" }

  root to: 'pages#login'

  get 'pages/app', as: 'home'

  resources :friends, only: [:index] do
    collection do
      put 'update_all'
    end
  end

  resources :groups
  resource  :association
  resource  :timeline, only: [:show] do
    member do
      put 'refresh'
    end
  end

end
