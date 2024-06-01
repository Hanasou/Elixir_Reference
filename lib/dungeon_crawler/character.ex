defmodule DungeonCrawler.Character do
  # This is how you define a struct
  defstruct name: nil,
            description: nil,
            hitpoints: 0,
            max_hit_points: 0,
            attack_description: nil,
            damage_range: nil
end
