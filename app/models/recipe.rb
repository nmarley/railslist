class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 250 }
end
