defmodule Peking.Repo do
  use Ecto.Repo,
    otp_app: :peking,
    adapter: Ecto.Adapters.Postgres
end
