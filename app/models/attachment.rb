class Attachment < ActiveRecord::Base
  belongs_to :user
  has_attached_file :media,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:style/:id/:filename"
  do_not_validate_attachment_file_type :media

  def md5sum; self.media_fingerprint; end

  scope :most_recent_first, -> { order(self.arel_table[:created_at].desc)}
  scope :for_user, ->(user_id) { where(user_id: user_id) }
end
