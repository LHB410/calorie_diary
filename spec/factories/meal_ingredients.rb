FactoryBot.define do
  factory :meal_ingredient do
    meal { nil }
    food { nil }
    weight_g { "9.99" }
    calories { "9.99" }
  end
end
