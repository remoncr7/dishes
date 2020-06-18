Rails.application.routes.draw do            

  get 'home/index'
  get 'home/show'
  root to: "home#index"
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  get "users/show" => "users#show"
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end


  # devise_for :users
  # root to: 'homes#index'
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  # get "/login", to: 'users#login'
  # get "/login", to: 'users#login'
  # get 'posts/create'
  # get 'posts/edit'
  # get 'posts/update'
  # get 'posts/destory'
   
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

