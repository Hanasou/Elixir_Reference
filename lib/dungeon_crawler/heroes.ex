defmodule DungeonCrawler.Heroes do
  # Alias allows us to use a shortcut for Character
  # So we can just write Character instead of DungeonCrawler.Character
  alias DungeonCrawler.Character

  def all, do: [
    %Character{},
    %Character{},
    %Character{},
  ]
end
