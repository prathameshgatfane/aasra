Rails.application.routes.draw do
  # Volunteer Applications route (RESTful)
  resources :volunteer_applications, only: [:create, :index]

  # Static Pages
  get 'contact', to: 'pages#contact'

  get "privacy", to: "pages#privacy"
  get "terms", to: "pages#terms"
  get "volunteers", to: "pages#volunteers"  # 👈 Added this line

  # Devise routes for Admin Users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root route
  root to: "home#index"

  # Devise routes for Normal Users
  devise_for :users

  # Shelter dashboard route - MUST COME BEFORE `resources :shelters`
  get 'shelters/dashboard', to: 'shelters#dashboard', as: 'shelters_dashboard'

  # Volunteer routes (NEW/CREATE for form functionality)
  resources :volunteers, only: [:new, :create]
  get 'volunteer', to: 'volunteers#new', as: 'volunteer'  # Form page at /volunteer

  # Foster and Events
  get 'fosters/index'
  get 'events', to: 'events#index', as: 'events'

  # Shelter search and animals
  get '/shelters/near/:zip', to: 'shelters#near'
  get '/shelters/:id/animals', to: 'shelters#animals'

  # Animals and adoptions
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

  resources :adoptions, only: [:index, :create, :new] do
    member do
      patch :update_status
    end
  end

  resources :adoptions, only: [] do
    member do
      patch :accept_adoption_request, to: 'shelters#accept_adoption_request'
      patch :reject_adoption_request, to: 'shelters#reject_adoption_request'
    end
  end

  resources :rescues do
    member do
      patch :take
      patch :resolve
      patch :convert_to_animal
    end
  end

  resources :donations, only: [:index, :create]
  get '/donate', to: 'donations#index', as: :donate

  resources :user_adoption_requests, only: [:index, :show, :new, :create]

  namespace :admin do
    resources :adoption_requests
  end
end
