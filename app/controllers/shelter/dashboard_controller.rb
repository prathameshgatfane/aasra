class Shelter::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_shelter!
  
    def index
      @shelter = current_user.shelter
  
      @adoption_requests = AdoptionRequest.joins(:animal)
                                          .where(animals: { shelter_id: @shelter.id })
  
      @volunteer_applications = VolunteerApplication.where(shelter_id: @shelter.id)
  
      @rescue_requests = Rescue.where(shelter_id: @shelter.id)
  
      # Optional: if you have donations
      # @donation_requests = DonationRequest.where(shelter_id: @shelter.id)
    end
  
    private
  
    def authorize_shelter!
      unless current_user.is_shelter? && current_user.approved?
        redirect_to root_path, alert: "Access denied"
      end
    end
  end
  