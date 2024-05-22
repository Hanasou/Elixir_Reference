defmodule Exercises do
  # This function pattern matches to a static argument
  # If we call this function and we don't receive an argument that matches this
  # Then we will get an error
  def total_points(%{strength: str, dexterity: dex, intelligence: int}) do
   (str * 2) + (dex * 3) + (int * 3)
  end

  # This is an idiomatic way to do control flow
  # Cases are represented in functions instead of classic structures like if, switch, or case
  def calculate_tax(salary) when salary <= 2000, do: 0
  def calculate_tax(salary) when salary <= 3000, do: salary * 0.05
  def calculate_tax(salary) when salary <= 6000, do: salary * 0.10
  def calculate_tax(salary) do: salary * 0.15

  user_input = IO.gets "Give me your salary: "
  result = case Float.parse(user_input) do
    :error -> 
        "Give me a number"
    {salary, _} ->
        take_home = salary - calculate_tax(salary)
        "Your take home pay is #{take_home}"
  end
end

