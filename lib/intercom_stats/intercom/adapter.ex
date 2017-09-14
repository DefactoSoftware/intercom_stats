defmodule IntercomStats.Intercom.Adapter do
  use HTTPoison.Base

  def process_url(url) do
    "https://api.intercom.io" <> url
  end

  defp process_request_headers(headers) do
    Enum.into(headers, [Accept: "application/json"])
  end
end
