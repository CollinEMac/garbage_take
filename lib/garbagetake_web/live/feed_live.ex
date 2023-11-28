defmodule GarbagetakeWeb.FeedLive do
  use Phoenix.LiveView
  alias Garbagetake.Feed
  alias Garbagetake.Repo
  alias Garbagetake.Post

  def render(assigns) do
    ~H"""
    <main>
      <h1>Timeline</h1>
      <div class="flex justify-center">
        <form phx-submit="create_post">
          <label>Post something!</label><br/>
          <input
            type="text"
            id="post-text"
            name="post-text"
            required
          />
          <button>Submit</button>
        </form>
      </div>
      <div>
        <%= for post <- @posts do %>
          <div>
            <p>
              USER_ID <%= post.user %> :
              <%= post.text %>
            </p>
            <p>
              SCORE <%= post.score %>
              <%!-- <%= post.tags %> --%>
            </p>
          </div>
        <% end %>
      </div>
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
    Repo.insert(%Post{
      user: socket.assigns.current_user.id,
      text: post_text,
      score: 0,
      tags: %{}
    })

    {
      :noreply,
      socket
      |> assign(:posts, Feed.get_posts())
    }
  end
end
