defmodule DungeonCrawler.Heroes do
  # Alias allows us to use a shortcut for Character
  # So we can just write Character instead of DungeonCrawler.Character
  alias DungeonCrawler.Character

  def all, do: [
    %Character{
      name: "Knight",
      description: "Strong defense and consistent damage",
      hit_points: 18,
      max_hit_points: 18,
      damage_range: 4..5,
      attack_description: "sword"
    },
    %Character{
      name: "Wizard",
      description: "Strong attack, low health",
      hit_points: 8,
      max_hit_points: 8,
      damage_range: 6..10,
      attack_description: "fireball"
    },
    %Character{
      name: "Rogue",
      description: "High variance attack",
      hit_points: 12,
      max_hit_points: 12,
      damage_range: 1..12,
      attack_description: "dagger"
    },
  ]
end
