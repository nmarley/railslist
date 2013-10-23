class Attachment < ActiveRecord::Base
  belongs_to :list
  has_attached_file :media,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:style/:id/:filename"
end
