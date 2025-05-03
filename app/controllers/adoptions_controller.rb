class AdoptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_adoption, only: [:update_status, :accept, :reject]
  before_action :ensure_shelter, only: [:accept, :reject]

  def create
    @animal = Animal.find(params[:animal_id])
    @shelter = @animal.shelter

    @request = current_user.adoption_requests.build(
      animal: @animal,
      message: params[:message],
      status: :requested,
      shelter_id: @shelter.id,
      reason: params[:reason],
      description: params[:description]
    )

    if @request.save
      redirect_to root_path, notice: "Adoption request submitted!"
    else
      render :new
    end
  end

  def index
    Rails.logger.debug "PARAMS: #{params.inspect}"

    @animals = Animal.includes(:category, :breed, :shelter).where(adoption_status: 'available')

    if params[:type].present? && params[:type] != "Animal Type"
      type_param = params[:type].to_s.downcase
      @animals = @animals.joins(:category).where('LOWER(categories.name) = ?', type_param)
    end

    if params[:age].present? && Animal.ages.key?(params[:age].downcase)
      @animals = @animals.where(age: params[:age].downcase)
    end

    if params[:gender].present? && Animal.genders.key?(params[:gender].downcase)
      @animals = @animals.where(gender: params[:gender].downcase)
    end

    if params[:size].present?
      size_param = params[:size].downcase.gsub(" ", "_")
      @animals = @animals.where(size: size_param) if Animal.sizes.key?(size_param)
    end

    Rails.logger.debug "Final Animal Query: #{@animals.to_sql}"

    @animals = @animals.page(params[:page]).per(10)
  end

  def new
    # Optional: Initialize form if needed
    def new
      @animal = Animal.find(params[:animal_id])
      @adoption_request = AdoptionRequest.new
    end
    
  end

  def shelter_dashboard
    @shelter = current_user.shelter
    @adoption_requests = AdoptionRequest.joins(:animal).where(animals: { shelter_id: @shelter.id })
  end

  def update_status
    if @adoption.update(status: params[:status])
      redirect_to shelters_dashboard_path, notice: "Request status updated to #{params[:status]}"
    else
      redirect_to shelters_dashboard_path, alert: "Failed to update status"
    end
  end

  def accept
    @adoption_request = AdoptionRequest.find(params[:id])
    if @adoption_request.update(status: 'accepted')
      redirect_to shelters_dashboard_path, notice: "Adoption request accepted."
    else
      redirect_to shelters_dashboard_path, alert: "Failed to accept the request."
    end
  end

  def reject
    @adoption_request = AdoptionRequest.find(params[:id])
    if @adoption_request.update(status: 'rejected')
      redirect_to shelters_dashboard_path, notice: "Adoption request rejected."
    else
      redirect_to shelters_dashboard_path, alert: "Failed to reject the request."
    end
  end

  private

  def set_adoption
    @adoption = AdoptionRequest.find(params[:id])
  end

  def ensure_shelter
    unless current_user.has_role?(:shelter)
      redirect_to root_path, alert: "Access denied."
    end
  end
end
