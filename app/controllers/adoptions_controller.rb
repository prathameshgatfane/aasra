class AdoptionsController < ApplicationController
    def create
        @animal = Animal.find(params[:animal_id])
        @request = current_user.adoption_requests.build(animal: @animal, message: params[:message], status: "Pending")

        if @request.save
        redirect_to @animal, notice: "Adoption request submitted!"
        else
        redirect_to @animal, alert: "There was a problem."
        end
    end

    def index
        @animals = Animal.all
    end   
    
    def new
    end
end
