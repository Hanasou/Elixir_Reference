defmodule DungeonCrawler.CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell

  import DungeonCrawler.CLI.BaseCommands

  def start do
    Shell.cmd("clear")
    Shell.info("Start by choosing your hero")

    # List that contains all the hero information
    heroes = DungeonCrawler.Heroes.all()
    find_hero_by_index = &Enum.at(heroes, &1)

    heroes
    |> display_options # Display the names of the heroes along with their indices
    |> generate_question # Offer a choice to the player
    |> Shell.prompt # Prompt will await an input from the user, and then it will return what the user has typed in, so that will be the input
    # in the next function of our pipeline
    |> parse_answer # All this does is parse the input and subtract by 1 to get the index
    |> find_hero_by_index.() # Anonymous function defined above to get the index of the hero
    # We can't use Enum.at/2 directly in the pipeline because the first argument it takes is the heroes list
    # We need to pass an Integer into it, which is the second argument
    |> confirm_hero
  end

  def confirm_hero(chosen_hero) do
    Shell.cmd("clear") # This will clear the screen
    Shell.info(chosen_hero.description)
    # The Shell.yes? function will prompt the user for a y/n response
    if Shell.yes?("Confirm?"), do: chosen_hero, else: start()
  end
end
