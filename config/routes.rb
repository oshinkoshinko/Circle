Rails.application.routes.draw do
   root to: 'public/homes#top'


  devise_for :members, skip: 'registrations', controllers: {
  sessions: 'public/sessions'
  }

  devise_scope :member do
    get 'edit' => 'public/registrations#edit'
    get '/members/sign_up' => 'public/registrations#new', as: :new_member_registration
    post '/members' => 'public/registrations#create'
  end


end
