class AddMd5sumToAttachment < ActiveRecord::Migration
  def up
    # add_column :attachments, :md5sum, :text
    add_column :attachments, :media_fingerprint, :text

    Attachment.all.each do |a|
      data = File.read(a.media.path)
      a.media_fingerprint = Digest::MD5.hexdigest(data)
      a.save
    end
  end

  def down
    remove_column :attachments, :media_fingerprint
    # remove_column :attachments, :md5sum
  end
end
