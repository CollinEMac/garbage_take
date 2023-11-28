defmodule GarbagetakeWeb.FeedController do
  use GarbagetakeWeb, :controller
  alias Phoenix.LiveView

  def feed(conn, _params) do
    # Render the main feed
    LiveView.Controller.live_render(conn, GarbagetakeWeb.FeedLive, session: %{
      "current_user" => conn.assigns.current_user
    })
  end
end
