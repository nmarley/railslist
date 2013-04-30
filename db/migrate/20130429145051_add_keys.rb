class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "items", "lists", :name => "items_list_id_fk"
    add_foreign_key "lists", "users", :name => "lists_user_id_fk"
  end
end
