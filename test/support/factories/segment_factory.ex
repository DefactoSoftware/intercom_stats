defmodule IntercomStats.SegmentFactory do
  defmacro __using__(_opts) do
    quote do
      def segment_factory do
        %IntercomStats.Intercom.Segment{
          id: sequence("segment_id"),
          name: sequence("segmentname"),
          person_type: sequence("persontype")
        }
      end
    end
  end
end
