class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :media
      t.references :list, index: true

      t.timestamps
    end
  end
end
