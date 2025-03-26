Rails.application.routes.draw do 
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :books, only: [:index, :show, :edit, :update, destroy]
  resources :users, only: [:index, :show, :edit, :update]
  root to: "homes#top"
  get "about" => "homes#about"
end
