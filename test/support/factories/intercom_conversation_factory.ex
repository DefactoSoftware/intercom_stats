defmodule IntercomStats.IntercomConversationFactory do
  defmacro __using__(_opts) do
    quote do
      def intercom_conversation_factory do
        %IntercomStats.Intercom.IntercomConversation{
          last_update: ~N[2014-06-13 00:00:00]
        }
      end
    end
  end
end
