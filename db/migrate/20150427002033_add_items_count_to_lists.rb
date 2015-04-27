class AddItemsCountToLists < ActiveRecord::Migration
  def change
    add_column :lists, :items_count, :integer
  end
end
