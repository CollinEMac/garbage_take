defmodule GarbagetakeWeb.FeedController do
  use GarbagetakeWeb, :controller

  def feed(conn, _params) do
    # Render the main feed
    render(conn, :feed)
  end
end
