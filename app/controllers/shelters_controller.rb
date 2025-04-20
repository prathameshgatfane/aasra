class SheltersController < ApplicationController
    before_action :set_shelter, only: %i[show edit update destroy]
  
    def index
      @shelters = Shelter.all
    end
  
    def show
      @shelter = Shelter.find(params[:id])
      @rescues_records = Rescue.all
    end
  
    def new
      @shelter = Shelter.new
    end
  
    def create
      @shelter = Shelter.new(shelter_params)
      if @shelter.save
        redirect_to @shelter, notice: "Shelter created successfully."
      else
        render :new
      end
    end
  
    def edit
    end
  
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
  
    private
  
    def set_shelter
      @shelter = Shelter.find(params[:id])
    end
  
    def shelter_params
      params.require(:shelter).permit(:name, :address, :phone)
    end  
end
