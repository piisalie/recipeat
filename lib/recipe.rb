class Recipe

  def self.find(recipe_id:, database_wrapper:)
    new(database_wrapper.get_recipe(recipe_id: recipe_id))
  end

  attr_reader :title, :description, :ingredients, :id

  def initialize(id:, title:, description:, ingredients:)
    @title       = title
    @description = description
    @ingredients = ingredients
    @id          = id
  end

end
