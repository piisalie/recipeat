require_relative '../lib/step'

describe Step do

  let(:directions)  { "Mix a lot" }
  let(:ingredients) { [ :pears, :honey ] }

  def build_a_step(directions: "", ingredients: [])
    Step.new(directions: directions, ingredients: ingredients)
  end

  it "has a .find interface" do
    dummy_db = double
    allow(dummy_db).to receive(:get_step)
      .with(recipe_id: 1, step_number: 2) { { directions: directions } }

    expect(Step.find(recipe_id: 1, step_number: 2, database_wrapper: dummy_db)).to be_a(Step)
  end

  it "can have ingredients" do
    step = build_a_step(ingredients: ingredients)
    expect(step.ingredients).to eq(ingredients)
  end

  it "knows if it has any ingredients" do
    step = build_a_step
    expect(step.has_ingredients?).to be(false)

    step_with_ingredients = build_a_step(ingredients: ingredients)
    expect(step_with_ingredients.has_ingredients?).to be true
  end

  it "has directions" do
    step = build_a_step(directions: directions)
    expect(step.directions).to eq(directions)
  end
end
