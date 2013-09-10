class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :instructions
      t.timestamps
    end
    add_index :recipes, :name, unique: true

    #create_table :ingredients_recipes do |t|
    create_table :recipe_ingredients do |t|
      t.references :recipe, null: false
      t.references :ingredient, null: false
      t.string :amount, null: false
    end
    add_index :recipe_ingredients, [:ingredient_id, :recipe_id], unique: true
    #add_index :ingredients_recipes, [:ingredient_id, :recipe_id], unique: true

  end
end
