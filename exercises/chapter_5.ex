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

  # Enums
  # Here are some examples of using the enum modules for basically the same functions we implemented up there
  def enum_examples() do
    string_list = ["dogs", "cats", "flowers"]
    number_list = [10, 5, 5, 10]
    # This will print each element in all caps
    # The & operator points to a named function when being used as an argument
    # &1 means we're passing in the first argument into this function
    # This would be the same as passing in a function like this
    # fn x -> IO.puts String.upcase(x)
    Enum.each(string_list, &(IO.puts String.upcase(&1)))

    # Map example
    # /1 refers to the function arity here. We're passing the String.capitalize function that takes in a single argument
    Enum.map(string_list, &String.capitalize/1)

    # Reduce example
    # This expression is kind of a weird one.
    # &+/2 refers to the basic addition expression.
    # You can think of addition as a function that passes in two arguments, which is what /2 is referring to.
    # So this is just a reduce function that sums up everything in the list.
    Enum.reduce(number_list, 0, &+/2)

    # Filter example
    # &(&1 > 5) is the same thing as fn x -> x > 5
    Enum.filter(number_list, &(&1 > 5))
  end

  # For comprehensions
  # Shorthand for basic map, reduce, and filter functions
  def comprehensions() do
    # This is the equivalent of a map function
    for a <- ["dogs", "cats", "flowers"], do: String.upcase(a)
  end

  # Delaying function execution
  def build(alphabet, positions) do
    # I'm not really seeing what the point of this exercise is
    # The point I guess is to delay the execution of a function by passing it into another one
    letters = Enum.map(positions, &String.at(alphabet, &1))
    Enum.join(letters)
  end

  # Streams
  # Streams are lazy collections. Which means the only data we load into memory is the amount that we need at the moment
  # Here's an implementation of factorial with a stream
  def factorial_of(0), do: 1
  def factorial_of(n) when n > 0 do
    # This stream is going to iterate to infinity
    # But in this case, we only take n numbers
    Stream.iterate(1, &(&1 + 1))
    |> Enum.take(n)
    |> Enum.reduce(&(&1 * &2))
  end

  # Here's another example of streams
  def give_candy(kids) do
    ~w(chocolate jelly mint)
    # Stream.cycle infinitey cycles the input. So in this case, it would go chocolate -> jelly -> mint -> chocolate -> jelly -> mint ...
    |> Stream.cycle
    # When we zip the stream with kids, because kids is a finite collection, the amount of candies we take from the stream collection
    # matches the size of the list of kids
    |> Enum.zip(kids)
  end
end
