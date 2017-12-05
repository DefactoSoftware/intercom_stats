# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     IntercomStats.Repo.insert!(%IntercomStats.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# add default user
IntercomStats.Repo.delete_all(IntercomStats.Coherence.User)

IntercomStats.Coherence.User.changeset(
  %IntercomStats.Coherence.User{},
  %{
    name: "Admin",
    email: "admin@defacto.nl",
    password: System.get_env("DEFAULT_USER_PASSWORD"),
    password_confirmation: System.get_env("DEFAULT_USER_PASSWORD")
  }
)
|> IntercomStats.Repo.insert!
