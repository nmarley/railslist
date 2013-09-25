class Recipe < ActiveRecord::Base
  #has_many :recipe_ingredients
  #has_many :ingredients, through: :recipe_ingredients
  #accepts_nested_attributes_for :ingredients

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 250 }

  validates :ingredients, presence: true

  #def recipe_ingredients_as_text
  #  list = self.recipe_ingredients.map do |ri|
  #    "#{ri.amount} #{ri.ingredient.name}"
  #  end
  #  list.join("\n")
  #end

end
