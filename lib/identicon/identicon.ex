defmodule Identicon do

  def main(input) do
    # Call a bunch of functions. Let's use the pipe operator
    input
    |> hash_string
    |> get_rgb
    |> build_grid()
    |> filter_odds()
  end

  def hash_string(input) do
    # Hash our input with the md5 algorithm
    hex = :crypto.hash(:md5, input)
    # Return a list of numbers which represents the key for our identicon
    |> :binary.bin_to_list

    # This is how we initialize a struct
    %Identicon.Image{hex: hex}
  end

  # Get the first three values of our image, which is a list of numbers
  # This represents the rgb value of our identicon
  def get_rgb(image) do
    # Let's recall that Elixir doesn't natively support indexing for arrays
    # So we can't grab the values with [0], [1], and [2]

    # Pattern match this list into three distinct values
    # Remember, for pattern matching, the left and right sides must be compatable
    # We're expecting the image value that gets passed into this function to be an Identicon.Image type
    # The syntax looks a little weird here, but what we're basically doing here is
    # destructuring the list object that's contained within "hex" into seperate r, g, and b variables.
    # | _tail basically means we're tossing away all the other values in the list
    %Identicon.Image{hex: [r, g, b | _tail]} = image

    # Return a new Image struct that contains a seperate tuple that contains our r, g, and b values
    # Some syntax clarification
    # What {image | color: {r, g, b}} means is that we're taking our old image struct
    # and we're appending a new value into our color field.
    # Remember that we're not mutating a struct in place, we're making a new one based off our old one
    %Identicon.Image{image | color: {r, g, b}}
  end

  # This function is identical to the one above, but refactored
  # Including both in here so you can see the difference
  # In here, we're pattern matching new r, g, and b values right when we pass image into the function
  # so we can return them in the function.
  def get_rgb_refactored(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    # So we generated a list of numbers for our image, now we have to build a symmetric grid off of it
    # The first thing we do is chunk the numbers into multiple lists
    # We do this with the Enum.chunk function, which will generate multiple lists based on what we pass into it
    grid = hex # Keep in mind that the pipe operator is passing in the hex variable into all these functions
    |> Enum.chunk_every(3, 3, :discard) # We're chunking our list into multiple lists each with 3 elements
    # The next thing we do is we have to mirror the values inside each chunk.
    # We'll write a helper function to do that
    |> Enum.map(&mirror_row/1)
    |> List.flatten() # Change our list of lists into just a single list
    |> Enum.with_index() # Pack all the values in our list with the index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # Takes in a single row of 3, and outputs a mirrored row of 5
    [first, second | _tail] = row
    # We use the ++ operator to join lists together
    row ++ [second, first]
  end

  def filter_odds(%Identicon.Image{grid: grid} = image) do
    # Just a reminder that variables that you want to throw away are prefaced with an underscore
    # Yeah we have some monster one-liners here.
    # Don't worry, just look at this carefully, and you'll get it
    %Identicon.Image{image | grid: Enum.filter(grid, fn({code, _index}) -> rem(code, 2) == 0 end)}
  end
end
