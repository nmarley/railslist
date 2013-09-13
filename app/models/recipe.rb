class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  accepts_nested_attributes_for :ingredients

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 250 }

  attr_accessor :name

  # TODO: I don't think this implementation is quite right.
  # I would rather accept nested attributes, or at least only parse a list of
  # ingredients. I am trying to avoid parsing, but it may be the easiest UI for
  # any user wanting to add/update recipe ingredients/amounts.
  def self.parse(input)
    data = input.dup
    r = self.new
    title_re = /^#\s*(.*)$/
    r.name = data.match(title_re)[1].strip
    data.sub!(title_re, '')

    ingredients_re = /^\s*\*\s*(.*$)/
    ingreds = []
    data.scan(ingredients_re) do |match|
      ingreds << match[0]
    end
    data.gsub!(ingredients_re, '')

    r.ingredients = []
    ingreds.each do |i|
      m = i.match(/^([\d\/\&\-\ ]+\ \w+)\s+(.*)$/)
      amount = m[1]
      ingredient_name = m[2]

      # add ingredient if not exist, get the id
      ingredient = Ingredient.where(name: ingredient_name).first_or_create
      r.recipe_ingredients.build(ingredient_id: ingredient.id, amount: amount)
    end

    r.instructions = data.strip
    r
  end
end
