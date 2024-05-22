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

  # Merge Sort
  # MergeSort in Elixir with pattern matching should be much cleaner than most imperative languages
  # First define the merge algorithm
  # If list_a is empty, then we just return list_b, and vice versa
  # Because if we merge a list with elements with an empty list, then we're just returning the list with elements
  defp merge([], list_b), do: list_b
  defp merge(list_a, []), do: list_a
  # Compare head_a to head_b. If head_b is greater than or equal to head_a, then we put head_a into the front of the list
  # Note that for list_b, we're defining head_b in the function parameter, and we're using _ to ignore the rest of the list since we don't need it
  defp merge([head_a | tail_a], list_b = [head_b | _]) when head_a <= head_b do
    [head_a | merge(tail_a, list_b)]
  end
  defp merge(list_a = [head_a | _], [head_b, tail_b]) when head_a > head_b do
    [head_b | merge(list_a, tail_b)]
  end

  def sort([]), do: []
  def sort([a]), do: [a]
  def sort(list) do
    # Get the median length of the list
    half_length = div(Enum.count(list), 2)
    # Split the list in half, put them into different values
    {list_a, list_b} = Enum.split(list, half_length)
    # Recursively call merge on sorted lists
    # Review recursion a little bit here
    # When we call sort, we're going to keep on dividing the list more and more until we get single element lists or 0 element lists
    # Single/Zero element lists are already sorted. So once that returns, then we keep calling merge on every single one of those
    merge(sort(list_a), sort(list_b))
  end

  # Tail call optimization
  # A function is tail recursive if the last expression in the function is a recursive call
  # Here's an example of how we can make a factorial body recursive function tail recursive
  def factorial(n), do: factorial_of(n, 1)
  defp factorial_of(0, acc), do: acc
  defp factorial_of(n, acc) when n > 0, do: factorial_of(n-1, n * acc)

  # Min and max recursive algorithms
  def min([], minimum), do: minimum
  def min([current | rest], current_min) when current < current_min do
    min([rest], current)
  end
  def min([current | rest], current_min) when current >= current_min do
    min([rest], current_min)
  end

  # Filter items
  def filter_items([], magic), do: []
  def filter_items([current = %{magic: magic} | rest], magic) do
    [current | filter_items(rest, magic)]
  end
  def filter_items([current | rest], magic) do
    filter_items(rest, magic)
  end
end
