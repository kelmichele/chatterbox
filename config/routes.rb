Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'

  get 'chatroom', to: 'static_pages#chatroom'
  get 'admin_chat', to: 'static_pages#admin_chat'
	get 'support', to: 'static_pages#support'

  mount ActionCable.server => '/cable'

  resources :conversations, only: [:create, :show] do
    member do
      post :close
    end

  	resources :messages, only: [:create]
  end


  resources :customer_chats, only: [:create] do
    member do
      post :close
    end

    resources :notes, only: [:create]
  end
end
