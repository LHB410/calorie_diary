class CreateMealIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_ingredients do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.decimal :weight_g
      t.decimal :calories

      t.timestamps
    end
  end
end
