defmodule KatoMarika.Util do
  alias Nostrum.Api

  # Helper function to add emoji to message controling ratelimit
  def add_reaction(msg, emoji) do
    Process.sleep(250)
    Api.create_reaction!(msg.channel_id, msg.id, emoji)
  end
end
