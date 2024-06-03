defprotocol DungeonCrawler.Display do
  # Here's how we define a protocol
  # A protocol is sort of like an interface. It allows us to use polymorphism

  # Both rooms and heroes are things that we want to display to the user
  # This function defininition doesn't care whether we pass in a hero or an action
  def info(value)
end

# To implement the protocol, we just need to implement the function for the data type that we want
# With this, we can display info and not have to worry whether we're passing in an action or character
defimpl DungeonCrawler.Display, for: DungeonCrawler.Room.Action do
  def info(action), do: action.label
end

defimpl DungeonCrawler.Display, for: DungeonCrawler.Character do
  def info(action), do: action.name
end
