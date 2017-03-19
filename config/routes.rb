Rails.application.routes.draw do
  devise_for :users

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
      post :unsave
    end
    member do
      post :checkin
    end
    collection do
      get :completed
    end
    resources :reviews
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :location_types
  resources :activities
  resources :distances, only: [:new, :create]
  resources :reviews
  root 'welcome#index'

end
