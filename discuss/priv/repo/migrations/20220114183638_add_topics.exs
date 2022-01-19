defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    # This set of instructions makes some intuitive sense, but where we're getting this from, I'm not sure
    # We're creating a table called topics, and we're adding a title field which is a string
    create table (:topics) do
      add :title, :string
    end
  end
end
