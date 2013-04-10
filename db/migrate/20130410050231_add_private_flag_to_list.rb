class AddPrivateFlagToList < ActiveRecord::Migration
  def change
    add_column :lists, :private, :boolean, { default: false }
  end
end
