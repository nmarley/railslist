class Attachment < ActiveRecord::Base
  belongs_to :user
  has_attached_file :media,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:style/:id/:filename"
  do_not_validate_attachment_file_type :media
end
