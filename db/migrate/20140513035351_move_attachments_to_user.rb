class MoveAttachmentsToUser < ActiveRecord::Migration
  def change
    rename_column :attachments, :list_id, :user_id
  end
end

# also need some SQL to do this:
# Attachment.all.each do |a|
#   uid = a.user_id
#   list = List.find(uid)
#   a.user_id = list.user_id
#   a.save
# end
