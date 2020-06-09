Rails.application.routes.draw do
  root "pages#home"
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, :only => [:show]
  resources :meals do
    resources :reviews, only: [:new, :create]
  end

  delete 'reviews/:id', to: 'reviews#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
