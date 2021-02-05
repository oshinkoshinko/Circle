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
  end

  scope module: :public do
   root to: 'homes#top'
  end

end
