class CacheItemCount < ActiveRecord::Migration
  def change
    execute "update lists set items_count = (select count(*) from items where list_id = lists.id)"
  end
end
