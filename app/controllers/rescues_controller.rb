class RescuesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :set_rescue, only: [:show, :take, :resolve]

    def index
      @rescues = current_user.rescues.open
    end
  
    def show
      @rescue = Rescue.find(params[:id])
    end
  
    def new
      @rescue = Rescue.new
    end
  
    def create
      @rescue = current_user.rescues.build(rescue_params)
      if @rescue.save
        redirect_to rescues_path, notice: "Rescue reported successfully!"
      else
        render :new
      end
    end
  
    def take
      @rescue.update(status: :taken, shelter: current_user.shelter)
      redirect_to @rescue, notice: "Rescue taken by your shelter"
    end
  
    def resolve
      @rescue.update(status: :resolved)
      redirect_to @rescue, notice: "Rescue marked as resolved"
    end

    def resolve
        @rescue.update(status: :resolved)
        @rescue.convert_to_animal # Convert rescue to an Animal
        redirect_to @rescue, notice: "Rescue marked as resolved and converted to Animal!"
    end

    private
  
    def set_rescue
      @rescue = Rescue.find(params[:id])
    end
  
    def rescue_params
      params.require(:rescue).permit(:image, :location, :description, :status, :user_id, :category_id, :breed_id)
    end
end