defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  @file_path "./resources/deck"

  def hello do
    :world
  end

  def create_deck do
    # Defining a list is pretty similar to Python
    # Also remember that the last element is what is automatically returned
    values = ["Ace", "One", "Two"]
    suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
    # This for loop means that for each suit inside suits
    # Do this thing. That part is expected
    # We can include both enumerables in the same comprehension
    for suit <- suits, value <- values do
      # But remember that this for loop is essentially a mapping function
      # This means that we're creating a brand new list.
      # In this case, we're creating the exact same list, because we're not doing anything with suit
      "#{value} of #{suit}" # <- Format print.
    end
  end

  def shuffle(deck) do
    # Don't have to import enum which is pretty cool
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck) do
    # In order to interact with our file system, we have to use erlang
    # This is how we access the erlang module

    # Convert our deck string into something that can be written to the file system
    binary = :erlang.term_to_binary(deck)
    # Write the thing to a file
    File.write(@file_path, binary)
  end

  def load() do
    # This is a pretty interesting structure known as a case.
    # It's kind of like pattern matching combined with if statements.
    # You can think of it like a switch in other languages.

    # We can switch on literals, or on variables.
    case File.read(@file_path) do
       {:ok, binary} -> :erlang.binary_to_term(binary)
       {:error, reason} ->
        case reason do
          :enoent -> "This file does not exist"
        end
    end
  end
end
