class SheltersController < ApplicationController
  before_action :set_shelter, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :ensure_shelter, only: [:dashboard]

  def index
    @shelters = Shelter.all
  end

  def show
    @rescues_records = Rescue.all
  end

  def new
    @shelter = current_user.build_shelter
  end

  def create
    @shelter = current_user.build_shelter(shelter_params)
    if @shelter.save
      redirect_to @shelter, notice: "Shelter created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @shelter.update(shelter_params)
      redirect_to @shelter, notice: "Shelter updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @shelter.destroy
    redirect_to shelters_path, notice: "Shelter deleted."
  end

  def animals
    shelter = Shelter.find(params[:id])
    animals = shelter.animals.select(:id, :name)
    render json: animals
  end

  def near
    coordinates = Geocoder.search(params[:zip]).first&.coordinates
    if coordinates
      @shelters = Shelter.near(coordinates, 50) # 50 km radius
      render json: @shelters.to_json(only: [:name, :latitude, :longitude, :address])
    else
      render json: { error: 'Location not found' }, status: :not_found
    end
  end

  def dashboard
    shelter = current_user.shelter
    @adoption_requests = if shelter
      AdoptionRequest.joins(:animal)
                     .where(animals: { shelter_id: shelter.id })
                     .where(status: 'requested')
    else
      []
    end
  end

  def accept_adoption_request
    @adoption_request = AdoptionRequest.find(params[:id])
    @adoption_request.update(status: 'accepted')
    redirect_to shelters_dashboard_path, notice: "Adoption request accepted."
  end

  def reject_adoption_request
    @adoption_request = AdoptionRequest.find(params[:id])
    @adoption_request.update(status: 'rejected')
    redirect_to shelters_dashboard_path, notice: "Adoption request rejected."
  end

  private

  def set_shelter
    @shelter = Shelter.find(params[:id])
  end

  def shelter_params
    params.require(:shelter).permit(:name, :address, :phone)
  end

  def ensure_shelter
    unless current_user&.is_shelter?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
