defmodule IntercomStats.IntercomAPIAdapter do
  @moduledoc false

  def get("/tags", _header, _options), do: tags()
  def get("/conversations", _header, _options), do: conversations()
  def get("/conversations/3", _header, _options), do: conversation3()
  def get("/conversations/2", _header, _options), do: conversation2()
  def get("/conversations/5", _header, _options), do: conversation5()
  def get("/conversations/6", _header, _options), do: conversation6()
  def get("/conversations/7", _header, _options), do: conversation7()
  def get("/conversations/8", _header, _options), do: conversation8()
  def get("/conversations/9", _header, _options), do: conversation9()
  def get("/users/1", _header, _options), do: user1()
  def get("/users/2", _header, _options), do: user2()
  def get(_, _, _), do: {:error, :forbidden}

  def start do
  end

  defp user1 do
    {:ok,
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
     }}
  end

  defp user2 do
    {:ok,
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
     }}
  end

  defp tags do
    {:ok,
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
     }}
  end

  defp conversations do
    {:ok,
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
             "updated_at" : 1500008003,
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
           },
           {
             "type": "conversation",
             "id": "5",
             "created_at" : 1500002000,
             "updated_at" : 1500009000,
             "user" : {
               "type": "user",
               "id" : "3"
             },
             "state": "closed"
           },
           {
             "type": "conversation",
             "id": "6",
             "created_at" : 1500002000,
             "updated_at" : 1500009000,
             "user" : {
               "type": "user",
               "id" : "3"
             },
             "state": "closed"
           },
           {
             "type": "conversation",
             "id": "7",
             "created_at" : 1500002000,
             "updated_at" : 1500009000,
             "user" : {
               "type": "user",
               "id" : "3"
             },
             "state": "closed"
           },
           {
             "type": "conversation",
             "id": "8",
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
             "id": "9",
             "created_at" : 1500002000,
             "updated_at" : 1500009000,
             "user" : {
               "type": "user",
               "id" : "2"
             },
             "state": "closed"
           }
         ]
       }
       """
     }}
  end

  defp conversation2 do
    {:ok,
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
               "part_type": "close",
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
     }}
  end

  defp conversation3 do
    {:ok,
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
             },
             {
               "type": "conversation_part",
               "id": "35",
               "part_type": "close",
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
     }}
  end

  defp conversation5 do
    {:ok,
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
               "body": "reply",
               "created_at": 1500020001,
               "updated_at": 1500020002,
               "author": {
                 "type": "bot",
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
             },
             {
               "type": "conversation_part",
               "id": "35",
               "part_type": "close",
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
     }}
  end

  defp conversation6 do
    {:ok,
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
               "id": "35",
               "part_type": "close",
               "body": "admin reply",
               "created_at": 1500030008,
               "updated_at": 1500030009,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             }
           ],
           "total_count": 3
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
     }}
  end

  defp conversation7 do
    {:ok,
     %{
       status_code: 200,
       body: """
       {
         "type": "conversation",
         "id": "7",
         "created_at": 1500002000,
         "updated_at": 1500009000,
         "conversation_message": {
           "type": "conversation_message",
           "id": "71",
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
               "id": "72",
               "part_type": "comment",
               "body": null,
               "created_at": 1500020001,
               "updated_at": 1500020002,
               "author": {
                 "type": "user",
                 "id": "2"
               }
             },
             {
               "type": "conversation_part",
               "id": "73",
               "part_type": "comment",
               "body": "reply",
               "created_at": 1500020006,
               "updated_at": 1500020007,
               "author": {
                 "type": "user",
                 "id": "2"
               }
             },
             {
               "type": "conversation_part",
               "id": "74",
               "part_type": "comment",
               "body": "user reply",
               "created_at": 1500030000,
               "updated_at": 1500030001,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "75",
               "part_type": "close",
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
     }}
  end

  defp conversation8 do
    {:ok,
     %{
       status_code: 200,
       body: """
       {
         "type": "conversation",
         "id": "8",
         "created_at": 1500002000,
         "updated_at": 1500009000,
         "conversation_message": {
           "type": "conversation_message",
           "id": "81",
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
               "id": "82",
               "part_type": "note",
               "body": "A first note",
               "created_at": 1500020001,
               "updated_at": 1500020002,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "83",
               "part_type": "comment",
               "body": "First reply",
               "created_at": 1500020002,
               "updated_at": 1500020003,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "84",
               "part_type": "note",
               "body": "A note",
               "created_at": 1500020004,
               "updated_at": 1500020005,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "85",
               "part_type": "comment",
               "body": "user reply",
               "created_at": 1500030000,
               "updated_at": 1500030001,
               "author": {
                 "type": "user",
                 "id": "2"
               }
             },
             {
               "type": "conversation_part",
               "id": "86",
               "part_type": "note",
               "body": "This is a note",
               "created_at": 1500030001,
               "updated_at": 1500030002,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "87",
               "part_type": "note",
               "body": "This is another note",
               "created_at": 1500030003,
               "updated_at": 1500030004,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "88",
               "part_type": "comment",
               "body": "admin reply",
               "created_at": 1500030008,
               "updated_at": 1500030009,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "89",
               "part_type": "close",
               "body": null,
               "created_at": 1500030009,
               "updated_at": 1500030009,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             }
           ],
           "total_count": 8
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
     }}
  end

  defp conversation9 do
    {:ok,
     %{
       status_code: 200,
       body: """
       {
         "type": "conversation",
         "id": "9",
         "created_at": 1500002000,
         "updated_at": 1500009000,
         "conversation_message": {
           "type": "conversation_message",
           "id": "91",
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
               "id": "92",
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
               "id": "94",
               "part_type": "snoozed",
               "body": null,
               "created_at": 1500020002,
               "updated_at": 1500020002,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "93",
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
               "id": "94",
               "part_type": "snoozed",
               "body": null,
               "created_at": 1500020008,
               "updated_at": 1500020008,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             },
             {
               "type": "conversation_part",
               "id": "95",
               "part_type": "comment",
               "body": "user reply",
               "created_at": 1500030000,
               "updated_at": 1500030001,
               "author": {
                 "type": "user",
                 "id": "2"
               }
             },
             {
               "type": "conversation_part",
               "id": "96",
               "part_type": "close",
               "body": "admin reply",
               "created_at": 1500030008,
               "updated_at": 1500030009,
               "author": {
                 "type": "admin",
                 "id": "100"
               }
             }
           ],
           "total_count": 5
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
     }}
  end
end
