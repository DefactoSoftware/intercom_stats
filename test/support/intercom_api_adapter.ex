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
      "/conversations" -> {:ok,
        %{
          status_code: 200,
          body: """
          {
            "conversations": [
              {
                "type": "conversation",
                "id": "147"
              }
            ]
          }
          """
        }
      }
      "/conversations/147" -> {:ok,
        %{
          status_code: 200,
          body: """
          {
            "type": "conversation",
            "id": "11480005803",
            "created_at": 1503925687,
            "updated_at": 1505727522,
            "waiting_since": 64619627100,
            "snoozed_until": null,
            "conversation_message":
            {
              "type": "conversation_message",
              "id": "126542917",
              "subject": "",
              "body": "<p>Hallo,</p>\n<p>We krijgen diverse meldingen dat het e-learning resultaat blijft onthouden na het opnieuw inschrijven terwijl in de instellingen onder e-learning staat aangevinkt dat resultaten worden gereset. </p>\n<p>ik heb 2 voorbeelden:<br>dhr HJ. vd Bos (112600) <br>heeft zich opnieuw ingeschreven voor Inleiding Ritmestoornissen en heeft al een 10 bij het starten.</p>\n<p>Mw. Y. Durinck (127600)<br>Heeft zich opnieuw ingeschreven voor Basic Life Support en heeft al een 10 bij het starten.</p>\n<p>Bij Henk-Jan heb ik al geprobeerd om te verwijderen van de e-learning cursus maar zodra hij zich inschrijft verschijnt weer het cijfer 10 en in de e-learning staat alles gemarkeerd met een vinkje.</p>\n<p>Het zijn beide modules van ExpertCollege. </p>\n<p>Weten jullie hoe we dit op kunnen lossen? </p>\n<p>gr<br>Roxanne Manuhutu</p>",
              "author": {
                "type": "user",
                "id": "56cdc8bb6fffd49c040007fe"
              },
              "attachments": [],
              "url": "https://asz.capp.nl/Administration/ManageELearningModules.aspx"
            },
            "user": {
              "type": "user",
              "id": "56cdc8bb6fffd49c040007fe"
            },
            "customers": [
              {
                "type": "user",
                "id": "56cdc8bb6fffd49c040007fe"
              }
            ],
            "assignee": {
              "type": "admin",
              "id": "262560"
            },
            "conversation_parts":
            {
              "type": "conversation_part.list",
              "conversation_parts":
              [
                {
                  "type": "conversation_part",
                  "id": "761402413",
                  "part_type": "comment",
                  "body": "<p>Hallo Roxanne, <br>Kunnen we die modules op staging testen? Dan kijken we even mee.</p>",
                  "created_at": 1503927996,
                  "updated_at": 1503927996,
                  "notified_at": 1503927996,
                  "assigned_to": {
                    "type": "admin",
                    "id": "111791"
                  },
                  "author": {
                    "type": "admin",
                    "id": "111791"
                  },
                  "attachments": [],
                  "external_id": null
                },
                {
                  "type": "conversation_part",
                  "id": "800552307",
                  "part_type": "comment",
                  "body": "<p>andere modules waarbij niet iets bij de leverancier worden bijgehouden resetten wel door onze functionaliteit</p>",
                  "created_at": 1505723126,
                  "updated_at": 1505723126,
                  "notified_at": 1505723126,
                  "assigned_to": null,
                  "author": {
                    "type": "admin",
                    "id": "262560"
                  },
                  "attachments": [],
                  "external_id": null
                },
                {
                  "type": "conversation_part",
                  "id": "800702774",
                  "part_type": "close",
                  "body": null,
                  "created_at": 1505727522,
                  "updated_at": 1505727522,
                  "notified_at": 1505727523,
                  "assigned_to": null,
                  "author": {
                    "type": "admin",
                    "id": "262560"
                  },
                  "attachments": [],
                  "external_id": null
                }
              ],
              "total_count": 3
            },
            "open": false,
            "state": "closed",
            "read": true,
            "tags":
            {
              "type": "tag.list",
              "tags": [
                  {
                      "type": "tag",
                      "id": "17523",
                      "name": "yo"
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
