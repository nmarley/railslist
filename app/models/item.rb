class Item < ActiveRecord::Base
  attr_accessible :content
  belongs_to :list

  before_save { List.update_all("updated_at = '#{0.seconds.ago}'", "id = '#{list_id}'") }
  validates :list_id, presence: true
  validates :content, presence: true

  default_scope order: 'items.updated_at DESC'
end
