defmodule Identicon do

  def main(input) do
    # Call a bunch of functions. Let's use the pipe operator
    image = hash_string(input)
    get_rgb(image.hex)
  end

  def hash_string(input) do
    # Hash our input with the md5 algorithm
    hex = :crypto.hash(:md5, input)
    # Return a list of numbers which represents the key for our identicon
    |> :binary.bin_to_list

    # This is how we initialize a struct
    %Identicon.Image{hex: hex}
  end

  def get_rgb(hex) do
    # Pattern match this list into three distinct values
    [r, g, b] = Enum.take(hex, 3)

    %Identicon.Image{hex: hex, color: {r, g, b}}
  end


end
