defmodule DungeonCrawler.Room do
  alias DungeonCrawler.Room
  alias DungeonCrawler.Room.Triggers

  import DungeonCrawler.Room.Action

  defstruct description: nil, actions: [], trigger: nil

  def all, do: [
    %Room{
      description: "You can see the light of day ahead. You've found the exit.",
      actions: [forward()],
      trigger: Triggers.Exit
    }
  ]
end
