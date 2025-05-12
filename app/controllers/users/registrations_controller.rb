class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if params[:user][:role_name] == 'shelter'
        user.approved = false
        user.save
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :email, :password, :password_confirmation,
      :full_name, :phone_number, :address, :role_name
    )
  end
end
