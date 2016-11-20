Rails.application.routes.draw do
  get 'reviews/new'

  resources :dips do |d|
    collection do
      get :location_types
    end
    collection do
      get :activities
    end
    member do
      post :create_selection
    end
  end
  resources :locations do 
    collection do
  		get :location_types
  	end
  	collection do
  		get :activities
  	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :location_types
  resources :activities
  resources :distances, only: [:new, :create]
  resources :reviews
  root 'welcome#index'

end
