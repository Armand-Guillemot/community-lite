Rails.application.routes.draw do
  root "pages#home"
  devise_for :users
  resources :meals do
    resources :reviews, only: [:new, :create]
  end

  delete 'reviews/:id', to: 'reviews#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
