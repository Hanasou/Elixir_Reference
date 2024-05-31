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

  # Pipelining Data
  # Enum vs Stream
  # Enum is for eager loading. Stream is for lazy loading.
  # Let's say we have a large data pipeline. With Enum, we have to wait for it to process all the data we send it before we send it to the next step
  # With Streams, once we're finished processing a batch of elements, we send it to the next step in the pipeline.
  # Let's see an example
  def run_eager(pieces) do
    pieces
    |> Enum.map(&add_thread/1)
    |> Enum.map(&add_head/1)
    |> Enum.each(&output/1)
  end

  defp add_thread(piece) do
    Process.sleep(50)
    piece <> "--"
  end

  defp add_head(piece) do
    Process.sleep(100)
    "o" <> piece
  end

  defp pack(pack) do
    Process.sleep(70)
    "|" <> piece <> "|"
  end

  defp output(screw) do
    IO.inspect(screw)
  end

  # Notice in the example above that the add_thread and add_head functions take a long time to complete.
  # We take a large number of pieces and apply the add_thread function to each of them.
  # With the Enum module, we have to wait for the add_thread function to get applied to all of them before passing them into add_head
  # and then we have to wait for all of them to complete before it gets sent to output
  # It's a simple change if we want to do lazy loading instead
  def run_lazy(pieces) do
    pieces
    |> Stream.map(&add_thread/1)
    |> Stream.map(&add_head/1)
    |> Enum.each(&output/1)
  end

  # All we did here was change this to use the stream api instead
  # How about modifying this example to be more realistic?
  # We can instead modify our code so that we're passing in batches of data to each step in the pipeline
  # To do that, we use the chunk function
  def run_lazy_batches(pieces) do
    pieces
    |> Stream.chunk(50)
    |> Stream.flat_map(&add_thread/1)
    |> Stream.chunk(100)
    |> Stream.flat_map(&add_head/1)
    |> Stream.chunk(30)
    |> Stream.flat_map(&pack/1)
    |> Enum.each(&output/1)
  end

  # Chunk will take our input list, and split it into batches of 50. So it will be a list of lists, with each list containing the specified number of elements
  # Enum.chunk([1,2,3,4,5,6], 2) = [[1,2], [3,4], [5,6]]
  # flat_map will "flatten" out our input list while also applying a mapping function. Because we're passing in a list of lists, we want a single list.
  # It's kind of the opposite of chunk where we're putting in a list of lists and getting a single list
  # Enum.flat_map([[1,2], [3,4], [5,6]], &(&1)) = [1,2,3,4,5,6]


  # Here's Quicksort in Elixir. Take the time to study it if you'd like
  def quicksort([]), do: []
  def quicksort([pivot | tail]) do
    {lesser, greater} = Enum.split_with(tail, &(&1 <= pivot))
    sort(lesser) ++ [pivot] ++ sort(greater)
  end
end
