defmodule IntercomStats.Intercom.ApiCalls do

  def retrieve_api_data do

  end

  def decode_json(json_input) do
    case JSON.decode(json_input) do
      {:ok, decoded_json} -> decoded_json
      {:error, _} -> "Something went wrong decoding the json"
    end
  end
end
