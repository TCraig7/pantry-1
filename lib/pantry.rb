class Pantry

  attr_reader   :stock,
                :shopping_list,
                :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, quantity)
    @stock[item] += quantity
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, quantity|
      @shopping_list[item] += quantity
    end
  end

  def print_shopping_list
    list = []
    @shopping_list.each do |item, quantity|
      list << "* #{item}: #{quantity}"
    end
    list.join("\n")
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    make = []
    @cookbook.each do |recipe|
      recipe.ingredients.all? do |item, quantity|
        if recipe.ingredients[item] <= @stock[item]
          make << recipe.name
        else
          recipe.name
        end
      end
    end
    make
  end
end
