class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    	user_params.permit(:name, :address, :email, :password, :password_confirmation, :current_password, :admin)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    	user_params.permit(:name, :address, :email, :password, :password_confirmation, :current_password, :admin)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
    	user_params.permit(:name, :address, :email, :password, :password_confirmation, :current_password, :admin)
    end
    #devise_parameter_sanitizer.for(:sign_in) << :name
    #devise_parameter_sanitizer.for(:account_update) << :name
  end
end
