require 'cuba'
require 'mote'
require 'mote/render'

require_relative 'lib/step'

class FakeDB
  def self.get_step(recipe_id:, step_number:)
    recipes = [ [ { directions: "Mix a lot, sir", ingredients: [ :pears ]} ] ]
    recipes[(recipe_id.to_i - 1)][(step_number.to_i - 1)]
  end
end

Cuba.plugin(Mote::Render)

Cuba.define do

  on "recipes/(\\d+)" do |id|
    res.write view("recipes/show", id: id)
  end

  on "recipes/(\\d+)-step-(\\d+)" do |recipe_id, step_number|
    step = Step.find(recipe_id: recipe_id, step_number: step_number, database_wrapper: FakeDB)
    res.write view("recipes/step", step: step)
  end

end
