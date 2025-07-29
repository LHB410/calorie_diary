class Meal < ApplicationRecord
  has_many :meal_ingredients, dependent: :destroy
  has_many :foods, through: :meal_ingredients

  validates :name, presence: true
  validates :date, presence: true

  accepts_nested_attributes_for :meal_ingredients,
                               allow_destroy: true,
                               reject_if: proc { |attributes| attributes["food_id"].blank? || attributes["weight_g"].blank? }

  scope :by_date, ->(date) { where(date: date) }
  scope :recent, -> { order(date: :desc, created_at: :desc) }
  scope :date_range, ->(start_date, end_date) { where(date: start_date..end_date) }

  before_save :calculate_total_calories

  def daily_meals
    Meal.by_date(date)
  end

  def daily_total_calories
    daily_meals.sum(:total_calories)
  end

  private

  def calculate_total_calories
    self.total_calories = meal_ingredients.reject(&:marked_for_destruction?).sum do |ingredient|
      ingredient.calories || 0
    end
  end
end
