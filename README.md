# IntercomStats

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## User specifics
Create the following file `config/user.secret.exs` with the following body:
```
use Mix.Config

# Configure your database
config :intercom_stats, IntercomStats.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "<username>",
  password: "<password>",
  database: "intercom_stats_dev",
  hostname: "localhost",
  pool_size: 10

# Configure adapters
config :intercom_stats, IntercomStats.Intercom.API,
  adapter: IntercomStats.Intercom.Adapter,
  token: "<intercom api access token>"
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
