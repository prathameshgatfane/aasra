# app/controllers/user_adoption_requests_controller.rb
class UserAdoptionRequestsController < ApplicationController
  before_action :authenticate_user!

  # List the adoption requests made by the current user
  def index
    @adoption_requests = AdoptionRequest.where(user: current_user)
  end

  # Show details for a specific adoption request
  def show
    @adoption_request = AdoptionRequest.find(params[:id])
  end

  # New adoption request form
  def new
    @adoption_request = AdoptionRequest.new
  end

  # Create a new adoption request
  def create
    @adoption_request = AdoptionRequest.new(adoption_request_params)
    @adoption_request.user = current_user
    @adoption_request.status = "pending"  # default status if you want

    if @adoption_request.save
      redirect_to @adoption_request, notice: 'Adoption request created successfully.'
    else
      render :new
    end
  end

  private

  # Strong parameters for adoption request
  def adoption_request_params
    params.require(:adoption_request).permit(:animal_id, :message)
  end
end
