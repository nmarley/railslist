class List < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 40 }

  default_scope order: 'lists.updated_at DESC'
end
