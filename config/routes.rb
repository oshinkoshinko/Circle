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
     end

  namespace :admin do
    root to: 'members#index'
    resources :genres, only: [:index, :create, :destroy]
  end

  scope module: :public do
   root to: 'homes#top'
   resources :members, only: [:show, :edit, :update]
   get 'members/unsubscribe' => 'members#unsubscribe'
   patch 'members/withdraw' => 'members#withdraw'
   resources :posts, only: [:index, :create, :edit, :update, :destroy] do
    resource :post_requests, only: [:index, :create, :destroy, :update]
   end
   get 'post_requests/waiting' => 'post_requests#waiting'
   resources :post_comments, only: [:show, :create, :destroy]
   get 'events/myevent' => 'events#myevent'
   resources :events do
    resources :event_members, only: [:new, :create, :show]
   end
  end

end
