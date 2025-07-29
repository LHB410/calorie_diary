class CreateMeals < ActiveRecord::Migration[8.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.date :date
      t.decimal :total_calories
      t.text :notes

      t.timestamps
    end
  end
end
