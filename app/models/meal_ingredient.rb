class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :food

  validates :weight_g, presence: true, numericality: { greater_than: 0 }
  validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_calories
  after_save :update_meal_total
  after_destroy :update_meal_total

  private

  def calculate_calories
    return unless food && weight_g

    self.calories = (food.calories_per_100g * weight_g / 100.0).round(2)
  end

  def update_meal_total
    meal.save if meal
  end
end
