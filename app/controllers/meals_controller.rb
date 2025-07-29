class MealsController < ApplicationController
  before_action :set_meal, only: [ :show, :edit, :update, :destroy ]

  def index
    @meals = Meal.recent.includes(:foods)
    @meals = @meals.by_date(params[:date].to_date) if params[:date].present?
  end

  def show
  end

  def new
    @meal = Meal.new(date: current_date)
    @meal.meal_ingredients.build
  end

  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      redirect_to @meal, notice: "Meal was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meal.update(meal_params)
      redirect_to @meal, notice: "Meal was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @meal.destroy
    redirect_to dashboard_index_path(date: @meal.date), notice: "Meal was successfully deleted."
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:name, :date, :notes,
      meal_ingredients_attributes: [ :id, :food_id, :weight_g, :_destroy ])
  end
end
