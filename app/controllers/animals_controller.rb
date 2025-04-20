class AnimalsController < ApplicationController
  def index
    @animals = Animal.available.includes(:breed, :shelter)
  end
  
  def show
    @animal = Animal.find(params[:id])
  end
  
  def new
    @animal = Animal.new
  end
  
  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      redirect_to @animal, notice: "Animal added successfully"
    else
      render :new
    end
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal.update(animal_params)
      redirect_to @animal, notice: "Adoption status updated!"
    else
      render :edit
    end
  end
  
  
  private
  
  def animal_params
    params.require(:animal).permit(:name, :age, :breed_id, :shelter_id, :adoption_status)
  end

  
end
