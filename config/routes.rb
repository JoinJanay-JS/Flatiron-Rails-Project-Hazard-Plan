require 'sidekiq/web'

Rails.application.routes.draw do

  resources :schedules do 
    resources :comments
    authenticate :users, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end 

 
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
