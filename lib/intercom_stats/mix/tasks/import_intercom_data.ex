defmodule Mix.Tasks.ImportIntercomData do
  @moduledoc """
  Imports tags and conversations from the intercom API.

    mix import_intercom_data
  """
  use Mix.Task

  import Mix.Ecto

  alias IntercomStats.Intercom.{Conversations, Tags}

  @impl true
  def run(_) do
    # start the Repo for interacting with data
    ensure_started(IntercomStats.Repo, [])

    Tags.save_from_api()
    Conversations.save_from_api()
  end
end
