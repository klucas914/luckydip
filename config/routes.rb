Rails.application.routes.draw do
  resources :dips do
    collection do
      get :location_types
    end
    collection do
      get :activities
    end
    member do
      post :pick_location, path: '/pick_location'
    end
  end
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :location_types
  resources :activities
  root 'welcome#index'

end
