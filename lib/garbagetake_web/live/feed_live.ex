defmodule GarbagetakeWeb.FeedLive do
  use Phoenix.LiveView
  alias Garbagetake.Feed
  alias Garbagetake.Repo
  alias Garbagetake.Post

  def render(assigns) do
    ~H"""
    <main>
      <div class="flex justify-center">
        <form phx-submit="create_post">
          <input
            type="text"
            id="post-text"
            name="post-text"
            placeholder="Post something!"
            required
          />
          <button>Post!</button>
        </form>
      </div>
      <h2>Timeline</h2>
      <table>
        <tr>
          <th>USER</th>
          <th>POST</th>
          <th>SCORE</th>
          <th>TAGS</th>
          <th>POST DATE</th>
          <th>upvote</th>
          <th>downvote</th>
        </tr>
        <%= for post <- @posts do %>
          <tr>
            <td>
              <%= post.user %>
            </td>
            <td>
              <%= post.text %>
            </td>
            <td>
              <%= post.score %>
            </td>
            <td>
              <%= for tag <- post.tags do %>
                <%= tag %>
              <% end %>
            </td>
            <td>
              <%= Date.to_iso8601(post.inserted_at) %>
            </td>
            <td>
              <button phx-click="upvote" phx-value-postid={post.id}>+</button>
            </td>
            <td>
              <button phx-click="downvote" phx-value-postid={post.id}>-</button>
            </td>
          </tr>
        <% end %>
      </table>
    </main>
    """
  end

  def mount(_params, session, socket) do
    current_user = Map.get(session, "current_user")
    posts = Feed.get_posts()
    {:ok, assign(socket, %{
      :posts => posts,
      :current_user => current_user
    })}
  end

  def handle_event("create_post", %{"post-text" => post_text}, socket) do

    Feed.create_or_update_post(
      socket.assigns.current_user.id,
      post_text
    )

    {
      :noreply,
      socket
      |> assign(:posts, Feed.get_posts())
    }
  end

  def handle_event("upvote", %{"postid" => post_id, "value" => _}, socket) do
    Repo.get!(Post, post_id)
    |> Post.increment_score()

    {
      :noreply,
      socket
      |> assign(:posts, Feed.get_posts())
    }
  end

  def handle_event("downvote", %{"postid" => post_id, "value" => _}, socket) do
    Repo.get!(Post, post_id)
    |> Post.decrement_score()

    {
      :noreply,
      socket
      |> assign(:posts, Feed.get_posts())
    }
  end
end
