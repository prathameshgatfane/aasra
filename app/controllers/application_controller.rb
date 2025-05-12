class ApplicationController < ActionController::Base
  before_action :authenticate_user_unless_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :email,
        :password,
        :password_confirmation,
        :full_name,
        :phone_number,
        :address,
        { role_ids: [] }
      ]
    )
    
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :email,
        :password,
        :password_confirmation,
        :current_password,
        :full_name,
        :phone_number,
        :address,
        { role_ids: [] }
      ]
    )
  end

  # Redirect users based on role after sign in
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser) && resource.shelter?
      shelters_dashboard_path
    else
      root_path
    end
  end

  def authenticate_user_unless_admin!
    authenticate_user! unless request.path.start_with?("/admin")
  end
end
