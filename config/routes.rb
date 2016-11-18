Rails.application.routes.draw do
  resources :dips do
    collection do
      get :location_types
    end
    collection do
      get :activities
    end
  end
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
