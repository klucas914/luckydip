Rails.application.routes.draw do
  devise_for :users
  get '/saved_locations', to: 'users#saved_locations'
  get '/completed_visits', to: 'users#completed_visits'
  get '/about', to: 'welcome#about'
  get 'contact', to: 'welcome#contact'
  get '/owners', to: 'welcome#owners'

  resources :dips, except: [:index, :edit, :update] do |d|
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
    member do
      post :save
    end
    member do
      patch :unsave
    end
    member do
      post :create_check_in
    end
    resources :reviews do
      member do
        post :new
      end
    end
  end
  
  resources :activities do
    member do
      post :hide
    end
    member do
      post :unhide
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :check_ins 
  resources :location_types
  resources :distances, only: [:new, :create]
  resources :reviews, except: [:index] 
  root 'welcome#index'

end
