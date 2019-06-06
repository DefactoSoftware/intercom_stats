use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :intercom_stats, IntercomStatsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

System.put_env("TAGS", "CAPP11")

# Configure your database
config :intercom_stats, IntercomStats.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "intercom_stats_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :intercom_stats, IntercomStats.Intercom.API, adapter: IntercomStats.IntercomAPIAdapter
