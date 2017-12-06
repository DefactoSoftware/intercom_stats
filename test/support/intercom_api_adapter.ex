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
              "name": "bug",
              "type": "tag"
              },
              {
              "id": "17523",
              "name": "consultancy",
              "type": "tag"
            }]
          }
          """
        }
      }
      "/conversations" -> {:ok,
        %{
          status_code: 200,
          body: """
          {
            "pages": {
              "total_pages": 1,
              "page": 1
            },
            "conversations": [
              {
                "type": "conversation",
                "id": "1",
                "created_at" : 1500001000,
                "updated_at" : 1500008000,
                "user" : {
                  "type": "user",
                  "id" : "1"
                },
                "state": "open"
              },
              {
                "type": "conversation",
                "id": "2",
                "created_at" : 1500001000,
                "updated_at" : 1500008000,
                "user" : {
                  "type": "user",
                  "id" : "1"
                },
                "state": "closed"
              },
              {
                "type": "conversation",
                "id": "3",
                "created_at" : 1500002000,
                "updated_at" : 1500009000,
                "user" : {
                  "type": "user",
                  "id" : "2"
                },
                "state": "closed"
              },
              {
                "type": "conversation",
                "id": "4",
                "created_at" : 1400000000,
                "updated_at" : 1400000000,
                "user" : {
                  "type": "user",
                  "id" : "3"
                },
                "state": "closed"
              }
            ]
          }
          """
        }
      }
      "/conversations/3" -> {:ok,
        %{
          status_code: 200,
          body: """
          {
            "type": "conversation",
            "id": "3",
            "created_at": 1500002000,
            "updated_at": 1500009000,
            "conversation_message": {
              "type": "conversation_message",
              "id": "31",
              "body": "<p> closed status </p>",
              "author": {
                "type": "user",
                "id": "2"
              }
            },
            "user": {
              "type": "user",
              "id": "2"
            },
            "conversation_parts":
            {
              "type": "conversation_part.list",
              "conversation_parts":
              [
                {
                  "type": "conversation_part",
                  "id": "32",
                  "part_type": "comment",
                  "body": null,
                  "created_at": 1500020001,
                  "updated_at": 1500020002,
                  "author": {
                    "type": "admin",
                    "id": "100"
                  }
                },
                {
                  "type": "conversation_part",
                  "id": "33",
                  "part_type": "comment",
                  "body": "reply",
                  "created_at": 1500020006,
                  "updated_at": 1500020007,
                  "author": {
                    "type": "admin",
                    "id": "100"
                  }
                },
                {
                  "type": "conversation_part",
                  "id": "34",
                  "part_type": "comment",
                  "body": "user reply",
                  "created_at": 1500030000,
                  "updated_at": 1500030001,
                  "author": {
                    "type": "user",
                    "id": "2"
                  }
                }
                {
                  "type": "conversation_part",
                  "id": "35",
                  "part_type": "comment",
                  "body": "admin reply",
                  "created_at": 1500030008,
                  "updated_at": 1500030009,
                  "author": {
                    "type": "admin",
                    "id": "100"
                  }
                }
              ],
              "total_count": 4
            },
            "state": "closed",
            "tags":
            {
              "type": "tag.list",
              "tags": [
                  {
                    "type": "tag",
                    "id": "17513",
                    "name": "bug"
                  },
                  {
                    "type": "tag",
                    "id": "17523",
                    "name": "consultancy"
                  }]
            }
          }
          """
        }
      }
      "/conversations/2" -> {:ok,
        %{
          status_code: 200,
          body: """
          {
            "type": "conversation",
            "id": "2",
            "created_at": 1500001000,
            "updated_at": 1500008003,
            "conversation_message": {
              "type": "conversation_message",
              "id": "21",
              "body": "<p> closed status, no tags </p>",
              "author": {
                "type": "user",
                "id": "1"
              }
            },
            "user": {
              "type": "user",
              "id": "1"
            },
            "conversation_parts":
            {
              "type": "conversation_part.list",
              "conversation_parts":
              [
                {
                  "type": "conversation_part",
                  "id": "22",
                  "part_type": "comment",
                  "body": "<p> part 1 </p>",
                  "created_at": 1500020000,
                  "updated_at": 1500020001,
                  "author": {
                    "type": "admin",
                    "id": "100"
                  },
                },
              ],
              "total_count": 1
            },
            "state": "closed",
            "tags":
            {
              "type": "tag.list",
              "tags": []
            }
          }
          """
        }
      }
      "/users/1" -> {:ok,
        %{
          status_code: 200,
          body: """
          {
            "type": "user",
            "id": "1",
            "companies": {
              "type": "company.list",
              "companies": [
                {
                  "name": "company_name_1"
                }
              ]
            }
          }
          """
        }
      }
      "/users/2" -> {:ok,
        %{
          status_code: 200,
          body: """
          {
            "type": "user",
            "id": "2",
            "companies": {
              "type": "company.list",
              "companies": [
                {
                  "name": "company_name_2"
                }
              ]
            }
          }
          """
        }
      }
    end
  end

  def start() do
  end
end
