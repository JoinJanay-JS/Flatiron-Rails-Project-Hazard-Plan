require 'sidekiq/web'

Rails.application.routes.draw do
  resources :schedules do 
    resources :comments
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end 

  devise_for :users
  root to: 'home#index'
  resources :users, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
