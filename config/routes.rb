Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new]

  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
