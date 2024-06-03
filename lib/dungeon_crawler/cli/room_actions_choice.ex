defmodule DungeonCrawler.CLI.RoomActionsChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawler.CLI.BaseCommands

  def start(room) do
    room_actions = room.actions
    find_action_by_index = &(Enum.at(room_actions, &1))

    Shell.info(room.description)

    chosen_action =
      room_actions
      |> display_options # Inside our BaseCommands module. This will list everything with an index.
      |> generate_question # Also inside BaseCommands, prompts user for choice
      |> Shell.prompt
      |> parse_answer
      |> find_action_by_index.()

    {room, chosen_action}
  end
end
