defmodule GarbagetakeWeb.FeedLive do
  use Phoenix.LiveView
  alias Garbagetake.Feed

  def render(assigns) do
    ~H"""
    <main>
      <h1>Timeline</h1>
      <div>
        <%= for post <- @posts do %>
          <div>
            Post!
            <%= post.text %>
          </div>
        <% end %>
      </div>
    </main>
    """
  end

  def mount(_params, _session, socket) do
    posts = Feed.get_posts()
    {:ok, assign(socket, :posts, posts)}
  end
end
