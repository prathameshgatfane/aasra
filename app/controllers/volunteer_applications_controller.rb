class VolunteerApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]

  def index
    @applications = current_user.volunteer_applications.order(created_at: :desc)
  end

  def create
    @application = current_user.volunteer_applications.build(volunteer_application_params)

    if @application.save
      redirect_to volunteer_applications_path, notice: "Thank you for applying to volunteer!"
    else
      flash.now[:alert] = "Please correct the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def volunteer_application_params
    params.require(:volunteer_application).permit(:name, :email, :phone, :interest_area, :message)
  end
end
