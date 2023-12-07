defmodule Garbagetake.Feed do
  @moduledoc """
  The main feed context
  """
  import Ecto.Query, warn: false
  alias Garbagetake.Repo
  alias Garbagetake.Post

  @doc """
  Returns all the saved posts
  """

  def create_or_update_post(user_id, text) do
    # Insert this post or increment the score on the existing post

    # There should only ever be one but whatever
    query = from p in Post, where: p.text == ^text, order_by: [desc: p.score], limit: 1
    posts_by_text = Repo.all(query)

    if posts_by_text do
      post_by_text = Enum.at(posts_by_text, 0)
      Post.increment_score(post_by_text)
    else
      Repo.insert!(%Post{
        user: user_id,
        text: text,
        score: 0,
        tags: %{},
      })
    end
  end

  def get_posts() do
    Repo.all(Post)
  end
end
