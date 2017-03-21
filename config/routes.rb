Rails.application.routes.draw do
  devise_for :users
  get '/saved_locations', to: 'users#saved_locations'
  get '/completed_visits', to: 'users#completed_visits'

  resources :dips do |d|
    member do
      post :create_selection
    end
    collection do
      get :locations
    end
    collection do
      get :location_types
    end
    collection do
      get :activities
    end
    member do
      get :location
    end
  end
  
  resources :locations do 
    collection do
      get :dips
    end
    collection do
  		get :location_types
  	end
  	collection do
  		get :activities
  	end
    collection do
      get :store, as: :user
    end
    member do
      post :save
    end
    member do
      patch :unsave
    end
    member do
      post :create_check_in
    end
    member do
      patch :uncheck
    end
    collection do
      get :completed
    end
    resources :reviews do
      member do
        post :new
      end
    end

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :check_ins do
    member do
      patch :uncheck, as: :user
    end
  end

  resources :location_types
  resources :activities
  resources :distances, only: [:new, :create]
  resources :reviews
  root 'welcome#index'

end
