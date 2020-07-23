Rails.application.routes.draw do
  resources :posts do
    resources :likes, only: %i[create destroy]
  end

  root to: 'posts#index'
  get 'posts/:id', to: 'posts#show'
  get '/my_post', to: 'posts#my_post'
  get '/user_post/:id', to: 'posts#user_post'
  get '/new', to: 'posts#new'
  post '/', to: 'posts#create'
  get 'posts/:id/edit', to: 'posts#edit'
  patch '/posts/:id/update', to: 'posts#update'
  get '/like', to: 'posts#like'
  # post "/posts/:post_id/likes", to: "likes#destroy"

  # get "/users", to: "users/registrations#new"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
