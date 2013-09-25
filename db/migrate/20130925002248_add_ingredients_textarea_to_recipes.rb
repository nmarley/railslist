# This is intended to be a temporary change until I can get the ingredients
# broken out into a model (done actually) and able to be displayed (done) and
# managed (NOT done) appropriately.
#
# nmarley, 2013-09-24
class AddIngredientsTextareaToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredients, :text
  end
end
