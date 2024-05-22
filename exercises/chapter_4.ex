defmodule Exercises do
  # Recursion
  # Instead of using an if statement to check for the exit condition, Elixir allows us to pattern match a function
  # Rememeber that the order matters when we define the function here
  def sum(0), do: 0
  def sum(n), do: n + sum(n-1)

  # Navigating through lists
  # Here's an example of how we might idiomatically work with a list
  # This is an example function of summing over all elements in a list
  def sum_list([]), do: 0
  def sum_list([head | remaining]), do: head + sum_list(remaining)

  # Transforming lists
  # The above is an example of a reduce function that sums everything up
  # What if we want a mapping function that applys a transformation over every element?
  # This function will add 3 to all elements in input list
  # We're also going to add a filter clause that adds the item without transforming if the current item is even
  def transform_items([]), do: [] 
  def transform_items([current | remaining]) when rem(current, 2) == 0 do
    [current | transform_items(remaining)]
  end
  def transform_items([current | remaining]) do
    new_item = current + 3
    [new_item | transform_items(remaining)]
  end

  # A useful note for pattern matching that I should probably put somewhere else besides here is that
  # pattern matching expressions that declare a variable have a return value.
  # So the statement, x = 5, will return 5
  # This is useful in case we want to do something like pattern match a function with 5, and we also want to declare a variable x to use in the function, such also
  # def some_func(x = 5), do: ...
  # This is identical to def some_func(5), do: ...
  # but we get to use x inside the function
  # In this case, this is kind of pointless, but it's more useful when we're pattern matching with maps and structs
end
