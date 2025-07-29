class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :calories_per_100g
      t.decimal :serving_size_g
      t.decimal :protein_g
      t.decimal :carbs_g
      t.decimal :fat_g

      t.timestamps
    end
  end
end
