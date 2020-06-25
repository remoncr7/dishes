Rails.application.routes.draw do            

  
  root to: "posts#index"
  get "/new", to:"posts#new"
  post "/", to:"posts#create"

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  } 
  
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
    post 'users/guest_sign_in', :to => 'users/sessions#new_guest'
  end
  
  
  resources :posts
end

