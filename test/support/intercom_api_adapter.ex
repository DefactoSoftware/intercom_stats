defmodule IntercomStats.IntercomAPIAdapter do
  def get(url, _header, _options) do
    case url do
      "/tags" -> {:ok, %{
        status_code: 200,
        body: """
        {
          "tags": [{
            "id": "17513",
            "name": "independent",
            "type": "tag"
            },
            {
            "id": "17523",
            "name": "independent2",
            "type": "tag"
          }]
        }
        """
      }}
    end
  end

  def start() do
  end
end
