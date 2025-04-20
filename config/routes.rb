Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "home#index"

  devise_for :users
  get '/shelters/:id/animals', to: 'shelters#animals'

  resources :animals do
    member do
      patch :adopt
    end
  end

  resources :shelters, only: [:index, :show, :new]
  resources :categories, only: [:index] do
    member do
      get :breeds
    end
  end
  resources :breeds, only: [:index]
  resources :adoptions, only: [:index, :create, :new]
  resources :rescues do
    member do
      patch :take
      patch :resolve
      patch :convert_to_animal # If manually triggering the conversion
    end
  end   
end
