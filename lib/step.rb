class Step

  def self.find(recipe_id:, step_number:, database_wrapper:)
    new(database_wrapper.get_step(recipe_id: recipe_id, step_number: step_number))
  end

  attr_reader :directions, :ingredients

  def initialize(directions:, ingredients: [])
    @directions  = directions
    @ingredients = ingredients
  end

  def has_ingredients?
    ingredients.any?
  end
end
