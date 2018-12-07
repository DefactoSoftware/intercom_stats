defmodule IntercomStats.Intercom.Adapter do
  @moduledoc """
  Adapter to connect to the Intercom api
  """

  use HTTPoison.Base

  def process_url(url) do
    "https://api.intercom.io" <> url
  end

  def process_request_headers(headers) do
    Enum.into(headers, Accept: "application/json")
  end
end
