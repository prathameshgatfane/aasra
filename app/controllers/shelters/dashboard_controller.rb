class Shelters::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_shelter!
  before_action :set_shelter

  def index
    if @shelter
      @adoption_requests = AdoptionRequest.joins(:animal)
                                          .where(animals: { shelter_id: @shelter.id })

      @volunteer_applications = VolunteerApplication.where(shelter_id: @shelter.id)

      @rescue_requests = Rescue.where(shelter_id: @shelter.id)
    else
      redirect_to root_path, alert: "Shelter not found."
    end
  end

  private

  def authorize_shelter!
    unless current_user&.is_shelter? && current_user.approved?
      redirect_to root_path, alert: "Access denied"
    end
  end

  def set_shelter
    @shelter = current_user.shelter
  end
end
