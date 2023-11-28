defmodule Garbagetake.Feed do
  @moduledoc """
  The main feed context
  """

  alias Garbagetake.Repo
  alias Garbagetake.Post

  @doc """
  Creates a post for the current user
  """

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns all the saved posts
  """

  def get_posts() do
    Repo.all(Post)
  end
end
