use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :peking, PekingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :peking, Peking.Repo,
  username: "postgres",
  password: "peking",
  database: "peking_test",
  hostname: System.get_env("PGHOST"),
  pool: Ecto.Adapters.SQL.Sandbox
