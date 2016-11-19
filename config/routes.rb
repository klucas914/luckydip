Rails.application.routes.draw do
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
  root 'welcome#index'

end
