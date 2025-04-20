class BreedsController < ApplicationController
    def index
      if params[:category_id]
        @breeds = Breed.where(category_id: params[:category_id])
      else
        @breeds = Breed.all
      end
  
      respond_to do |format|
        format.html
        format.json { render json: @breeds }
      end
    end
  end  
end
