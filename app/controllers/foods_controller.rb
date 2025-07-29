class FoodsController < ApplicationController
  def index
    @foods = Food.all.order(:name)
    @foods = @foods.by_name(params[:search]) if params[:search].present?
  end

  def search
    food_name = params[:q]
    @food = Food.find_or_fetch_from_api(food_name) if food_name.present?

    respond_to do |format|
      format.json { render json: @food }
      format.html { redirect_to foods_path(search: food_name) }
    end
  end
end
