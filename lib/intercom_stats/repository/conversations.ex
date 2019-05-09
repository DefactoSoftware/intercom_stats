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
        {:tag, nil}, query ->
          query
          |> join(:left, [c], t in assoc(c, :tags))
          |> where([c, t], is_nil(t.id))
        {_, nil}, query -> query
        {:company_name, company_name}, query ->
          from c in query, where: ilike(c.company_name, ^"%#{company_name}%")
        {:from_date, from_date}, query ->
          from c in query, where: c.open_timestamp >=
            ^string_date_to_unix(from_date)
        {:to_date, to_date}, query ->
          from c in query, where: c.closed_timestamp <=
            ^string_date_to_unix(to_date)
        {:tag, tag}, query ->
          query
          |> join(:inner, [c], t in assoc(c, :tags))
          |> where([c, t], t.name == ^tag)
      end)
    |> Repo.all
  end

  def conversation_averages_by_company(filter \\ %{}) do
    filter
    |> list_all_conversations()
    |> Enum.group_by(&(&1.company_name))
    |> Enum.map(fn {key, value} -> map_stats(value, key) end)
    |> Enum.sort(fn(%{company_name: a}, %{company_name: b}) ->
      String.capitalize(a) <= String.capitalize(b)
    end)
  end

  def conversation_stats_by_tag_and_company(filter) do
    filter
    |> list_all_conversations()
    |> map_stats(filter.company_name)
  end

  defp map_stats(list, name) do
    %{
      company_name: name,
      average_first_response: get_average(:time_to_first_response, list),
      average_closing_time: get_average(:closing_time, list),
      number: get_number(list)
    }
  end

  def get_average(key, conversations) do
    conversations
    |> Enum.map(fn(conversation) ->
        Map.get(conversation, key)
      end)
    |> Enum.filter(fn(time) -> time != nil end)
    |> calculate_average()
    |> to_readable_time()
  end

  def calculate_average([]), do: nil
  def calculate_average(list) do
    round(Enum.sum(list) / Enum.count(list))
  end

  def conversation_number_by_company(filter) do
    filter
    |> list_all_conversations()
    |> map_number(filter.company_name)
  end

  defp map_number(list, name) do
    %{
      company_name: name,
      number: get_number(list),
    }
  end

  def get_number(conversations) do
    count_messages(conversations)
  end

  def count_messages([]), do: nil
  def count_messages(list) do
    Enum.count(list)
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
