defmodule KatoMarika.Events.EventHandler do
  use Alchemy.Events
  # alias Alchemy.{Client, Cache, User, Embed, Webhook}
  # import Embed

  Events.on_message(:inspect)
  def inspect(message) do
    IO.inspect message.content
  end


end
