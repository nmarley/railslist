class CreateUserListPermissions < ActiveRecord::Migration
  def change
    create_table :user_list_permissions do |t|
      t.references :user, index: true
      t.references :list, index: true
      t.string :permission

      t.timestamps
    end
  end
end
