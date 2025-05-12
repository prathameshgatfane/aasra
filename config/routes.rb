Rails.application.routes.draw do
  # Devise for Admin and Users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Root
  root to: "home#index"

  # Shelter Dashboard and Request Management
  namespace :shelter do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :adoption_requests, only: [:index, :update]
    resources :volunteer_applications, only: [:index, :update]
    resources :rescue_requests, only: [:index, :update]
  end

  # Volunteer Applications
  resources :volunteer_applications, only: [:create, :index]

  # Volunteers
  resources :volunteers, only: [:new, :create]
  get 'volunteer', to: 'volunteers#new', as: 'volunteer'

  # Static Pages
  resources :fosters, only: [:index]
  resources :events, only: [:index]

  get 'contact', to: 'pages#contact'
  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  get 'volunteers', to: 'pages#volunteers'
  get 'my_adoption_requests', to: 'adoptions#my_requests', as: 'my_adoption_requests'

  # Shelters public routes
  get '/shelters/near/:zip', to: 'shelters#near'
  get '/shelters/:id/animals', to: 'shelters#animals'
  resources :shelters, only: [:index, :show, :new]

  # Categories & Breeds
  resources :categories, only: [:index] do
    member do
      get :breeds
    end
  end
  resources :breeds, only: [:index]

  # Animals & Nested Adoptions
  resources :animals do
    member do
      patch :adopt
    end
    resources :adoptions, only: [:new, :create]
  end

  # Adoptions
  resources :adoptions, only: [:index] do
    member do
      patch :update_status
      patch :accept_adoption_request, to: 'shelters#accept_adoption_request'
      patch :reject_adoption_request, to: 'shelters#reject_adoption_request'
    end
  end

  # Rescues
  resources :rescues do
    member do
      patch :take
      patch :resolve
      patch :convert_to_animal
    end
  end

  # Donations
  resources :donations, only: [:index, :create]
  get '/donate', to: 'donations#index', as: :donate

  # User Adoption Requests
  resources :user_adoption_requests, only: [:index, :show, :new, :create]

  # Admin namespace
  namespace :admin do
    resources :adoption_requests
  end
end
