defmodule Garbagetake.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :user, :integer
    field :text, :string
    field :score, :integer
    field :tags, :map
    field :"timestamps()", :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user, :score, :text, :tags, :"timestamps()"])
    |> validate_required([:user, :score, :text, :"timestamps()"])
  end
end
