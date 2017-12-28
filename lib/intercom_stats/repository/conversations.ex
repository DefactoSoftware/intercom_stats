defmodule IntercomStats.Repository.Conversations do
  @moduledoc """
  This module provides functions to retrieve persisted conversation information
  from the database
  """
  use Timex

  import Ecto.Query
  import IntercomStatsWeb.Gettext

  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Repo

  def list_all_conversations(filter \\ %{}) do
    filter
    |> Enum.reduce(Conversation, fn
        {_, nil}, query -> query
        {:company_name, company_name}, query ->
          from c in query, where: ilike(c.company_name, ^"%#{company_name}%")
        {:from_date, from_date}, query ->
          from c in query, where: c.open_timestamp >= ^string_date_to_unix(from_date)
        {:to_date, to_date}, query ->
          from c in query, where: c.closed_timestamp <= ^string_date_to_unix(to_date)
      end)
    |> Repo.all
  end

  def list_conversations_by_tags(:or, tags_list) do
    query = from t in "tags",
            join: ct in "conversations_tags", on: t.id == ct.tag_id,
            join: c in "conversations", on: ct.conversation_id == c.id,
            where: t.id in ^tags_list,
            select: %Conversation{id: c.id}

    query
    |> Repo.all()
    |> Enum.uniq_by(fn %{id: id} -> id end)
  end

  def conversation_averages_by_company(filter \\ %{}) do
    list_all_conversations(filter)
    |> Enum.group_by(&(&1.company_name))
    |> Enum.map(fn {key, value} ->
      %{
        company_name: key,
        average_first_response: get_average(:time_to_first_response, value),
        average_closing_time: get_average(:closing_time, value)
      }
    end)
    |> Enum.sort(fn(%{company_name: a}, %{company_name: b}) ->
      String.capitalize(a) <= String.capitalize(b)
    end)
  end

  def get_average(key, conversations) do
    conversations
    |> Enum.map(fn(conversation) ->
        Map.get(conversation, key)
      end)
    |> Enum.filter(fn(time) -> time != nil end)
    |> Enum.sum()
    |> calculate_average(conversations)
    |> to_readable_time()
  end

  def calculate_average(_, []), do: nil
  def calculate_average(total, list) do
    round(total / Enum.count(list))
  end

  def string_date_to_unix(date) do
    date
    |> Timex.parse!("{YYYY}-{0M}-{0D}")
    |> Timex.to_datetime
    |> DateTime.to_unix
  end

  defp to_readable_time(seconds) when seconds == nil,
    do: gettext("Er zijn geen gesprekken beschikbaar")
  defp to_readable_time(seconds) do
    seconds
    |> Duration.from_seconds
    |> Timex.format_duration(:humanized)
  end
end
