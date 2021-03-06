defmodule Cards do
  @moduledoc """
  This represents a deck of cards and its associated functions.
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

  @doc """
    Function documentation is written like this.
  """
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

  @doc """
  Divides the deck into a hand and the remainder of the deck.
  hand_size is the number of elements in the hand
  """
  def deal(deck, hand_size) do
    # Split takes two elements
    # The first is a list, and the second is an integer.
    # We take the number of elements from that integer and
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

  def create_hand(hand_size) do
    # We're able to chain the return values of functions together with the pipe operator
    # The result of create_deck is going to get passed into Cards.shuffle
    # Result of shuffle is going to get passed into deal (deal normally takes in two arguments, but only has one because deck is automatically passed in)
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
