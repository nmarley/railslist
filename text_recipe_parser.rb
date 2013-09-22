
require 'pp'

class Ingredients
  def parse(data)
    ingredients_re = /^\s*\*\s*(.*$)/
    ingreds = []
    data.scan(ingredients_re) do |match|
      ingreds << match[0]
    end
    data.gsub!(ingredients_re, '')

    @ingredients = []
    ingreds.each do |i|
      m = i.match(/^([\d\/\&\-\ ]+\ \w+)\s+(.*)$/)
      @ingredients << m[1, 2]
    end
  end
end


class TextRecipe
  attr_reader :title, :ingredients, :instructions

  def initialize(data)
    parse(data)
  end

  private
  def parse(data)
    title_re = /^#\s*(.*)$/
    @title = data.match(title_re)[1].strip
    data.sub!(title_re, '')

    ingredients_re = /^\s*\*\s*(.*$)/
    ingreds = []
    data.scan(ingredients_re) do |match|
      ingreds << match[0]
    end
    data.gsub!(ingredients_re, '')

    @ingredients = []
    ingreds.each do |i|
      m = i.match(/^([\d\/\&\-\ ]+\ \w+)\s+(.*)$/)
      @ingredients << m[1, 2]
    end

    @instructions = data.strip
  end
end

#data = File.read("recipe.md")
#r = TextRecipe.new(data)

#p r.title
#p r.ingredients
#p r.instructions

