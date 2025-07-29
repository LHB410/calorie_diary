FactoryBot.define do
  factory :food do
    name { "MyString" }
    calories_per_100g { "9.99" }
    serving_size_g { "9.99" }
    protein_g { "9.99" }
    carbs_g { "9.99" }
    fat_g { "9.99" }
  end
end
