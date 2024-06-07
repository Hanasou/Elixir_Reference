defmodule DungeonCrawler.CLI.Main do
  # This module provides some useful stuff when working with the shell
  alias Mix.Shell.IO, as: Shell

  def start_game() do
    welcome_message()
    Shell.prompt("Press Enter to continue")
    crawl(hero_choice(), DungeonCrawler.Room.all)
  end

  defp welcome_message do
    Shell.info("== Dungeon Crawl ==")
    Shell.info("You awake in a dungeon full of monsters")
    Shell.info("You need to survive and find the exit")
  end

  defp hero_choice do
    DungeonCrawler.CLI.HeroChoice.start()
  end

  defp crawl(character, rooms) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("clear")

    rooms
    |> Enum.random() # Pull a rando mroom for the list of rooms
    |> DungeonCrawler.CLI.RoomActionsChoice.start() # Allow the user to choose from a list of actions in this room
    |> trigger_action(character)
    |> handle_action_result
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("clear")
    room.trigger.run(character, action)
  end

  defp handle_action_result({_, :exit}),
    do: Shell.info("You are winner")
  defp handle_action_result({character, _}),
    do: crawl(character, DungeonCrawler.Room.all())
end
