require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_stock_returns_empty_hash_by_default
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_it_can_check_stock_levels
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_it_can_restock_pantry
    pantry = Pantry.new

    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_shopping_list_is_empty_by_default
    pantry = Pantry.new

    assert_equal ({}), pantry.shopping_list
  end

  def test_it_can_add_recipe_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")

    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(r)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list
  end

  def test_it_can_add_multiple_recipes_to_shopping_list
    pantry = Pantry.new

    r_1 = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r_1)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Spaghetti Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r_2)

    expected = {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

    assert_equal expected, pantry.shopping_list
  end

  def test_it_can_print_shopping_list
    pantry = Pantry.new

    r_1 = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r_1)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Spaghetti Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r_2)

    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

    assert_equal expected, pantry.print_shopping_list
  end

end
