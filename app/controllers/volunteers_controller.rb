class VolunteersController < ApplicationController
  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.save
      redirect_to root_path, notice: "Thank you for applying to volunteer!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(
      :first_name, :last_name, :email, :phone, :address, :city, :state, :zip_code,
      :age, :preferred_position, :other_position, :availability,
      :experience, :motivation
    )
  end
end
