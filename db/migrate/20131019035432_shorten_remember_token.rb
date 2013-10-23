class ShortenRememberToken < ActiveRecord::Migration
  def change
    change_column :users, :remember_token, :string, limit: 22
  end
end
