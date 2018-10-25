# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :intercom_stats,
  ecto_repos: [IntercomStats.Repo]

# Configures the endpoint
config :intercom_stats, IntercomStatsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7nqkHxuBDAyqv7PFekn/owiY5/4cEugOqzFOToQL10bybcsPjs9jEljan3tOS20H",
  render_errors: [view: IntercomStatsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: IntercomStats.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :sentry,
  dsn:
    "https://#{System.get_env("SENTRY_PUBLIC_KEY")}:#{System.get_env("SENTRY_SECRET_KEY")}@#{
      System.get_env("SENTRY_APP")
    }.getsentry.com/1",
  environment_name: :prod,
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  tags: %{
    env: "production"
  },
  included_environments: [:prod]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: IntercomStats.Coherence.User,
  repo: IntercomStats.Repo,
  module: IntercomStats,
  web_module: IntercomStatsWeb,
  router: IntercomStatsWeb.Router,
  messages_backend: IntercomStatsWeb.Coherence.Messages,
  logged_out_url: "/sessions/new",
  opts: [:authenticatable]

# %% End Coherence Configuration %%
