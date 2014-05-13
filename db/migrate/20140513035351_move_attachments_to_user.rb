class MoveAttachmentsToUser < ActiveRecord::Migration
  def change
    rename_column :attachments, :list_id, :user_id
  end
end
