require 'cuba'
require 'mote'
require 'mote/render'

require_relative 'lib/step'
require_relative 'lib/recipe'

class FakeDB
  def self.get_step(recipe_id:, step_number:)
    steps = [ [ { directions: "Mix a lot, sir", ingredients: [ :pears ]} ] ]
    steps[(recipe_id.to_i - 1)][(step_number.to_i - 1)]
  end

  def self.get_recipe(recipe_id:)
    recipes = [ {
      id:    1,
      title: "Stone Soup",
      description: "A soup, made from stones and kindness",
      ingredients: [ :pears ],
    } ]
    recipes[(recipe_id.to_i - 1)]
  end

end

Cuba.plugin(Mote::Render)

Cuba.define do

  on "recipes/(\\d+)" do |id|
    recipe = Recipe.find(recipe_id: id, database_wrapper: FakeDB)
    res.write view("recipes/show", recipe: recipe)
  end

  on "recipes/(\\d+)-step-(\\d+)" do |recipe_id, step_number|
    step = Step.find(recipe_id: recipe_id, step_number: step_number, database_wrapper: FakeDB)
    res.write view("recipes/step", step: step)
  end

end
