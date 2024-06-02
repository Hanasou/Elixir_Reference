defmodule DungeonCrawler.Room.Action do
  alias DungeonCrawler.Room.Action

  defstruct label: nil, id: nil

  def forward, do: %Action{id: :forward, label: "Move forward."}
  def rest, do: %Action{id: :rest, label: "Take a better look a rest."}
  def search, do: %Action{id: :search, label: "Search the room"}
end
