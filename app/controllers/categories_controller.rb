class CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def show
        @category = Category.find(params[:id])
        @breeds = @category.breeds
    end      

    def breeds
        @breeds = Breed.where(category_id: params[:id])
        render json: @breeds
      end
end
