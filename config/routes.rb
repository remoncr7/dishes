Rails.application.routes.draw do
  devise_for :users
  get "/login", to: 'users#login'
  root to: 'homes#index'
  get "/login", to: 'users#login'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destory'
   
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
