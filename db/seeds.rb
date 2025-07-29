# Create some sample foods for testing
foods_data = [
  { name: "Apple", calories_per_100g: 52, serving_size_g: 100, protein_g: 0.3, carbs_g: 14, fat_g: 0.2 },
  { name: "Banana", calories_per_100g: 89, serving_size_g: 100, protein_g: 1.1, carbs_g: 23, fat_g: 0.3 },
  { name: "Chicken Breast", calories_per_100g: 165, serving_size_g: 100, protein_g: 31, carbs_g: 0, fat_g: 3.6 },
  { name: "Brown Rice", calories_per_100g: 123, serving_size_g: 100, protein_g: 2.6, carbs_g: 23, fat_g: 0.9 },
  { name: "Broccoli", calories_per_100g: 34, serving_size_g: 100, protein_g: 2.8, carbs_g: 7, fat_g: 0.4 }
]

foods_data.each do |food_data|
  Food.find_or_create_by(name: food_data[:name]) do |food|
    food.assign_attributes(food_data)
  end
end

puts "Created #{Food.count} foods"

# Create a sample meal for today
today_meal = Meal.create!(
  name: "Breakfast",
  date: Date.current,
  notes: "Healthy start to the day"
)

# Add ingredients to the meal
apple = Food.find_by(name: "Apple")
banana = Food.find_by(name: "Banana")

if apple && banana
  MealIngredient.create!(meal: today_meal, food: apple, weight_g: 150)
  MealIngredient.create!(meal: today_meal, food: banana, weight_g: 120)
end

puts "Created sample meal with ingredients"
