use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :env_eh, EnvEh.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :env_eh, EnvEh.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "ben",
  # password: "postgres",
  database: "env_eh_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
