# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :peking,
  ecto_repos: [Peking.Repo]

# Configures the endpoint
config :peking, PekingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IUDbeSsLSepne7k7/CiluzR1PlHw3neEVTSybPUoy6ZU4IHUnEC62ytZHgMCI5r9",
  render_errors: [view: PekingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Peking.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
