class AllowNullInRecipeIngredients < ActiveRecord::Migration
  def change
    change_column :recipe_ingredients, :amount, :string, null: true
  end
end
