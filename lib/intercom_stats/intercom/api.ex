defmodule IntercomStats.Intercom.API do
  @adapter Application.get_env(:intercom_stats, __MODULE__)[:adapter]
  @token Application.get_env(:intercom_stats, __MODULE__)[:token]

  def get(url, params \\ []) do
    options = params ++ [timeout: 50_000, recv_timeout: 50_000]
    @adapter.start
    @adapter.get(
      url,
      [Authorization: "Bearer #{@token}"],
      options
    )
  end

  def decode_json(input) do
    case JSON.decode(input) do
      {:ok, decoded_json} -> decoded_json
      {:error, _} -> "Something went wrong decoding the json"
    end
  end
end
