defmodule IntercomStats.Mixfile do
  use Mix.Project

  def project do
    [
      app: :intercom_stats,
      version: "0.0.1",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {IntercomStats.Application, []},
      extra_applications: [:logger, :runtime_tools, :httpoison, :coherence]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:absinthe, "~> 1.4.0-beta", override: true},
      {:absinthe_ecto, ">= 0.0.0"},
      {:absinthe_phoenix, "~> 1.4.0-beta", override: true},
      {:absinthe_plug, "~> 1.4.0-beta", override: true},
      {:coherence, "~> 0.5"},
      {:plug_cowboy, "~> 2.0"},
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:ex_machina, "~> 2.1", only: :test},
      {:gettext, "~> 0.11"},
      {:httpoison, "~> 1.4"},
      {:json, "~> 1.0"},
      {:phoenix, "~> 1.4.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix_pubsub, "~> 1.0"},
      {:poison, "~> 3.0", override: true},
      {:postgrex, ">= 0.0.0"},
      {:quantum, ">= 2.1.0"},
      {:sentry, "~> 7.2.4"},
      {:timex, "~> 3.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
