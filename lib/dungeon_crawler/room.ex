defmodule DungeonCrawler.Room do
  alias DungeonCrawler.Room

  import DungeonCrawler.Room.Action

  defstruct description: nil, actions: []

  def all, do: [
    %Room{
      description: "You found a quiet place. Looks safe for a little nap",
      actions: [forward(), rest()]
    }
  ]
end
