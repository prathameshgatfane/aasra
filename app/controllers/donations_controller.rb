class DonationsController < ApplicationController
  def index
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)

    if @donation.save
      redirect_to donate_path, notice: "Thank you for your donation!"
    else
      flash.now[:alert] = "Something went wrong."
      render :index
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :frequency, :first_name, :last_name, :email, :phone, :dedicated)
  end
end
