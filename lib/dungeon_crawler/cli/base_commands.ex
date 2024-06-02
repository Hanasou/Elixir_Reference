defmodule DungeonCrawler.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def display_options(options) do
    options
    |> Enum.with_index(1) # This function will pack options in a tuple alongside an index
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}") # This is the string interpolation syntax
    end)

    options
  end

  def generate_question(options) do
    options = Enum.join(1..Enum.count(options),",") # Create a comma separated list with the numbers that are associated with our choices
    "Which one? [#{options}]\n" # Return a string containing the options
  end

  def parse_answer(answer) do
    {option, _} = Integer.parse(answer)
    option - 1
  end

end
