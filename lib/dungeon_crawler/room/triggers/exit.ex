defmodule DungeonCrawler.Room.Triggers.Exit do
  @behaviour DungeonCrawler.Room.Trigger

  def run(character, _), do: {character, :exit}
end
