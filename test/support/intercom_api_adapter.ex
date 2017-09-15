defmodule IntercomStats.IntercomAPIAdapter do
  def get(url, _header, _options) do
    case url do
      "/tags" -> {:ok,
        %{
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
        }
      }
      "/segments" -> {:ok,
        %{
          status_code: 200,
          body: """
            {
              "segments": [
                {
                  "type": "segment",
                  "id": "5891fa4df75e473c03fb28a6",
                  "name": "ASZ",
                  "created_at": 1485961805,
                  "updated_at": 1500300558,
                  "person_type": "user"
                },
                {
                  "type": "segment",
                  "id": "5587d8fc1756993f30002377",
                  "name": "Active",
                  "created_at": 1434966268,
                  "updated_at": 1505459141,
                  "person_type": "user"
                }
              ]
            }
          """
        }
      }
    end
  end

  def start() do
  end
end
