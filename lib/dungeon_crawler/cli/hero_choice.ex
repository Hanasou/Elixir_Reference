defmodule DungeonCrawler.CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell

  def start do
    Shell.cmd("clear")
    Shell.info("Start by choosing your hero")

    heroes = DungeonCrawler.Heroes.all()

    heroes
    |> Enum.map(&(&1.name))
    |> display_options
  end

  def display_options(options) do
    options
    |> Enum.with_index(1) # This function will pack options in a tuple alongside an index
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}") # This is the string interpolation syntax
    end)

    options
  end

end
