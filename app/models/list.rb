class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :user_list_permissions, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 200 }

  default_scope -> { order('lists.updated_at DESC') }

  def feed
    items
  end

  def self.search(search)
    if search
      where('lower(name) like lower(?)', "%#{search}%")
    else
      all
    end
  end
end
