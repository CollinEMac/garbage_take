defmodule Garbagetake.Repo do
  use Ecto.Repo,
    otp_app: :garbagetake,
    adapter: Ecto.Adapters.Postgres
end
