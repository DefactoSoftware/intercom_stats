defmodule IntercomStats.ConversationFactory do
  defmacro __using__(_opts) do
    quote do
      def conversation_factory do
        %IntercomStats.Intercom.Conversation{
          segment_id: insert(:segment).id,
          tags: insert_list(2, :tag),
          time_to_first_response: 10,
          closing_time: 10,
          total_response_time: 10,
          average_response_time: 10
        }
      end
    end
  end
end
