class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permit additional Devise sign-up params
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_name])
  end

  # Redirect users based on role after sign in
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser) && resource.shelter?
      shelters_dashboard_path
    else
      root_path
    end
  end
end
