defmodule IntercomStats.TagFactory do
  defmacro __using__(_opts) do
    quote do
      def tag_factory do
        %IntercomStats.Intercom.Tag{
          id: sequence("id"),
          name: sequence("tagname")
        }
      end
    end
  end
end
