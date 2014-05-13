class UpdateUserIdData < ActiveRecord::Migration
  def up
    Attachment.all.each do |a|
      list = List.find(a.user_id)
      a.user_id = list.user_id
      a.save
    end
  end

  def down
    # not much we can do to restore changed data
    raise ActiveRecord::IrreversibleMigration, "Can't recover the updated data"
  end
end
