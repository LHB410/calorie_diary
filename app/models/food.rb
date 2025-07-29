class Food < ApplicationRecord
  has_many :meal_ingredients, dependent: :destroy
  has_many :meals, through: :meal_ingredients

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :calories_per_100g, presence: true, numericality: { greater_than: 0 }

  scope :by_name, ->(name) { where("name ILIKE ?", "%#{name}%") }

  def self.find_or_fetch_from_api(food_name)
    food = find_by("name ILIKE ?", food_name.strip)
    return food if food

    CalorieNinjasService.new.fetch_food_data(food_name)
  end
end
