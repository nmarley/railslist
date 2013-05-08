class Item < ActiveRecord::Base
  attr_accessible :content
  belongs_to :list, touch: true

  validates :list_id, presence: true
  validates :content, presence: true

  default_scope order: 'items.updated_at DESC'
end
