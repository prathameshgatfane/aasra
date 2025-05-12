class Users::SessionsController < Devise::SessionsController
  before_action :check_shelter_approval, only: [:create]

  protected

  # Redirect approved shelter users to their dashboard after sign in
  def after_sign_in_path_for(resource)
    if resource.is_shelter? && resource.approved?
      shelter_dashboard_path
    else
      super
    end
  end

  private

  # Prevent unapproved shelters from signing in
  def check_shelter_approval
    user = User.find_by(email: params[:user][:email])

    if user&.is_shelter? && !user.approved?
      flash[:alert] = "Your shelter account is awaiting admin approval."
      redirect_to new_user_session_path
    end
  end
end
