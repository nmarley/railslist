class AddCascadesToDbFks < ActiveRecord::Migration
  def change
    remove_foreign_key :items, { :name => "items_list_id_fk" }
    remove_foreign_key :lists, { :name => "lists_user_id_fk" }
    add_foreign_key :lists, :users,
      :name => "lists_user_id_fk", dependent: :delete
    add_foreign_key :items, :lists,
      :name => "items_list_id_fk", dependent: :delete
  end
end
