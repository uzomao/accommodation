class ApplicationController < ActionController::Base
  respond_to :html, :json
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

 before_action :configure_permitted_parameters, if: :devise_controller?

 protected

  def configure_permitted_parameters
   # Permit the `first_name, last_name, is_landlord?` parameters along with the other
   # sign up parameters.
   # extra_params = [:email, :first_name, :last_name, :is_landlord]
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({  roles: [] }, :email, :first_name, :last_name, :is_landlord, :password, :password_confirmation) }
  end
end
