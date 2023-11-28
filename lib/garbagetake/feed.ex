defmodule Garbagetake.Feed do
  @moduledoc """
  The main feed context
  """

  alias Garbagetake.Repo
  alias Garbagetake.Post

  @doc """
  Returns all the saved posts
  """

  def get_posts() do
    Repo.all(Post)
  end
end
