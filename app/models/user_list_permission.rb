class UserListPermission < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates :permission, :inclusion => { :in => %w[ r w ] }
end
