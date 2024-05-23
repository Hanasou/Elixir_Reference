defmodule Exercises do
  # We can implement map, reduce, filter, and foreach functions with higher order functions here
  def map([], _function), do: []
  def map([current | rest], function) do
    [function.(current) | map(rest, function)]
  end

  def reduce([], accumulator, _function), do: accumulator
  def reduce([current | rest], accumulator, function) do
    reduce(rest, function.(current, accumulator), function)
  end

  def filter([], _function), do: []
  def filter([current | rest], function) do
    if function.(current) == true do
      [current | filter(rest, function)]
    else
      filter(rest, function)
    end 
  end

  # For comprehensions
  # Shorthand for basic map, reduce, and filter functions
  def comprehensions() do
    # This is the equivalent of a map function
    for a <- ["dogs", "cats", "flowers"], do: String.upcase(a)
  end
end
