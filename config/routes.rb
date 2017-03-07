Rails.application.routes.draw do
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
      get :store
    end
    member do
      post :save
    end
    member do
      delete :unsave
    end
    member do
      post :checkin
    end
    collection do
      get :completed
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :location_types
  resources :activities
  resources :distances, only: [:new, :create]
  resources :reviews
  root 'welcome#index'

end
