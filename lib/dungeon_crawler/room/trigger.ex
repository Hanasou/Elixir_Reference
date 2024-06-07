defmodule DungeonCrawler.Room.Trigger do
  # This is how to define a behaviour. I hate that this is spelled with a u.
  # Any module using this behaviour must implement the functions that are listed here
  # So what's the meaningful difference between Protocols and Behaviours?

  # Protocols define functions that are applied on data
  # We define a protocol that has function signatures
  # We define implementations that do different things depending on what data type we pass into it

  # Behaviours also have a list of functions in them
  # But modules themselves implement these behaviours
  # If a module implements a behaviour, it needs to implement the functions defined in that behaviour
  @callback run(character :: any, action :: any) :: any
end
