Rails.application.routes.draw do            

  
  root to: "posts#index"
  get "/new", to:"posts#new"
  post "/", to:"posts#create"

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end
  
  
  resources :posts
end

