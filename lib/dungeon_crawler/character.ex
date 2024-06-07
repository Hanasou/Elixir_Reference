defmodule DungeonCrawler.Character do
  # This is how you define a struct
  # Structs take the name of the module they're defined in
  defstruct name: nil,
            description: nil,
            hit_points: 0,
            max_hit_points: 0,
            attack_description: nil,
            damage_range: nil

  defimpl String.Chars do
    def to_string(character), do: character.name
  end
end
