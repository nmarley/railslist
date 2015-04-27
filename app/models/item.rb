class Item < ActiveRecord::Base
  belongs_to :list, touch: true, counter_cache: true

  validates :list_id, presence: true
  validates :content, presence: true

  default_scope -> { order('items.updated_at DESC') }

  scope :search, ->(search) do
    if search
      where(arel_table[:content].matches("%#{search}%"))
    else
      none
    end
  end

  scope :for_user, ->(user_id) do
    if user_id
      where(list_id: List.for_user(user_id).pluck(:id))
    else
      none
    end
  end
end
