defmodule Mix.Tasks.Start do
  use Mix.Task

  # We can run new tasks as a sort of alias for different things we want to do.
  # In this case, we're going to run 'mix start' in our command line and it will run the run function in here
  # We can use this to start our app
  def run(_), do: IO.puts "Hello World from Start"
end
