Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'

	get 'chatroom', to: 'static_pages#chatroom'
  get 'home', to: 'home#index'

  mount ActionCable.server => '/cable'

  resources :conversations, only: [:create] do
    member do
      post :close
    end

  	resources :messages, only: [:create]
  end
end
