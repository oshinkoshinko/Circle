Rails.application.routes.draw do

  devise_for :members, skip: 'registrations', controllers: {
  sessions: 'public/sessions'
  }

  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  devise_scope :member do
    get 'edit' => 'public/registrations#edit'
    get '/members/sign_up' => 'public/registrations#new', as: :new_member_registration
    post '/members' => 'public/registrations#create'
    post '/members/guest_sign_in', to: 'public/sessions#new_guest'
     end

  namespace :admin do
    root to: 'members#index'
    resources :genres, only: [:index, :create, :destroy]
    resources :events, only: [:index]
  end

  scope module: :public do
   root to: 'homes#top'
   patch 'members/unsubscribe' => 'members#unsubscribe'
   get 'members/withdraw' => 'members#withdraw'
   resources :members, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'follow' => 'relationships#follow'
    get 'unfollow' => 'relationships#unfollow'
   end
   resources :posts, only: [:index, :create, :edit, :update, :destroy] do
    resource :post_requests, only: [:index, :create, :destroy, :update]
   end
   get 'post_requests/waiting' => 'post_requests#waiting'
   resources :post_comments, only: [:show, :create, :destroy]
   get 'events/myevent' => 'events#myevent'
   resources :events do
    get 'event_members/complete' => 'event_members#complete'
    resources :event_members, only: [:new, :create, :show, :update, :destroy]
   end
   get 'chats/:id' => 'chats#show'
   resources :chats, only: [:create, :destroy]
   get 'rooms' => 'rooms#index'
   resources :notifications, only: [:index]
   delete 'notifications' => 'notifications#destroy_all'
  end

  resources :inquiries, only: [:new, :create]

end
