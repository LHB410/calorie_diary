class DashboardController < ApplicationController
  def index
    @current_date = current_date
    @meals = Meal.by_date(@current_date).includes(:meal_ingredients, :foods)
    @daily_total = @meals.sum(:total_calories)
    @weekly_data = weekly_calorie_data
  end

  private

  def weekly_calorie_data
    end_date = @current_date
    start_date = end_date - 6.days

    Meal.date_range(start_date, end_date)
        .group(:date)
        .sum(:total_calories)
        .map { |date, calories| { date: date.strftime("%a"), calories: calories } }
  end
end
