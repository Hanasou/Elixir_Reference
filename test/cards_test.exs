defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "greets the world" do
    assert Cards.hello() == :world
  end

  test "create deck makes 12 cards" do
    deck_length = length(Cards.create_deck)
    # This is how you do assertion. You know how it is.
    assert deck_length == 12
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck()
    # Refute is basically the opposite of assert.
    # You can assert the negation of this statement to get the same behavior
    refute deck == Cards.shuffle(deck)
  end
end
