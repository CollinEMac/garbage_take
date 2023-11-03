defmodule Garbagetake.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user, :integer
      add :score, :integer
      add :text, :text
      add :tags, :map
      add :"timestamps()", :string

      timestamps()
    end
  end
end
