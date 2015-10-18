require_relative '../lib/recipe'

describe Recipe do

  let(:id)          { 2 }
  let(:title)       { "Stone Soup" }
  let(:description) { "Your favorite community dish." }
  let(:ingredients) { [ :stones ] }

  def build_a_recipe(id: 1, title: "", description: "", ingredients: [])
    Recipe.new(id: id, title: title, description: description, ingredients: ingredients)
  end

  it "has a .find interface" do
    dummy_db = double
    allow(dummy_db).to receive(:get_recipe)
      .with(recipe_id: id) { { id: id, title: title, description: description, ingredients: ingredients } }

    expect(Recipe.find(recipe_id: id, database_wrapper: dummy_db)).to be_a(Recipe)
  end

  it "has an id" do
    recipe = build_a_recipe(id: id)
    expect(recipe.id).to eq(id)
  end

  it "has a title" do
    recipe = build_a_recipe(title: title)
    expect(recipe.title).to eq(title)
  end

  it "has a description" do
    recipe = build_a_recipe(description: description)
    expect(recipe.description).to eq(description)
  end

  it "can have ingredients" do
    recipe = build_a_recipe(ingredients: ingredients)
    expect(recipe.ingredients).to eq(ingredients)
  end

end
