defmodule Garbagetake.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garbagetake.Repo

  schema "posts" do
    field :user, :integer
    field :text, :string
    field :score, :integer
    field :tags, :map
    field :"timestamps()", :string

    timestamps()
  end

  def increment_score(post) do
    Repo.update!(
      Ecto.Changeset.change post, score: post.score + 1
    )
  end

  def decrement_score(post) do
    Repo.update!(
      Ecto.Changeset.change post, score: post.score - 1
    )
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user, :score, :text, :tags, :"timestamps()"])
    |> validate_required([:user, :score, :text, :"timestamps()"])
  end
end
