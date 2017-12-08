defmodule IntercomStats.TagFactory do
  defmacro __using__(_opts) do
    quote do
      def tag_factory do
        %IntercomStats.Intercom.Tag{
          id: sequence("tag_id"),
          name: sequence("tagname")
        }
      end

      def tag_bug_factory do
        %IntercomStats.Intercom.Tag{
          id: sequence("tag_id1"),
          name: "bug"
        }
      end

      def tag_support_factory do
        %IntercomStats.Intercom.Tag{
          id: sequence("tag_id2"),
          name: "gebruikersondersteuning"
        }
      end
    end
  end
end
