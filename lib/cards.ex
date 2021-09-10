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
end
