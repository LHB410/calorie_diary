class CalorieNinjasService
  include HTTParty
  base_uri "https://api.api-ninjas.com/v1"

  def initialize
    @api_key = ENV.fetch["CALORIE_NINJAS_API_KEY"]
  end

  def fetch_food_data(food_name)
    response = self.class.get("/nutrition", {
      query: { query: food_name },
      headers: { "X-Api-Key" => @api_key }
    })

    if response.success? && response["items"]&.any?
      create_food_from_api_response(response["items"].first, food_name)
    else
      Rails.logger.error "CalorieNinjas API error: #{response.code} - #{response.message}"
      nil
    end
  rescue => e
    Rails.logger.error "CalorieNinjas API exception: #{e.message}"
    nil
  end

  private

  def create_food_from_api_response(item, original_name)
    Food.create!(
      name: item["name"] || original_name,
      calories_per_100g: item["calories"] || 0,
      serving_size_g: item["serving_size_g"] || 100,
      protein_g: item["protein_g"] || 0,
      carbs_g: item["carbohydrates_total_g"] || 0,
      fat_g: item["fat_total_g"] || 0
    )
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create food: #{e.message}"
    nil
  end
end
