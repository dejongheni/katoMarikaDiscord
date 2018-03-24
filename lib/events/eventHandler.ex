defmodule KatoMarika.Events.EventHandler do
  use Alchemy.Events
  alias KatoMarika.Events.PinoHandler
  # alias Alchemy.{Client, Cache, User, Embed, Webhook}
  # import Embed

  Events.on_message(:inspect)
  def inspect(message) do
    require Alchemy.Cogs
    commander = Application.get_env(:katomarikadiscord, :commander)
    botID = Application.get_env(:katomarikadiscord, :botID)
    pinoID = Application.get_env(:katomarikadiscord, :pinoID)

    IO.inspect message.author.id <> message.content


    case message.author.id do
      ^commander -> Nil #Alchemy.Cogs.say message.author.id <> " " <> commander
      ^botID -> Nil
      ^pinoID -> PinoHandler.received(message)
      _ -> Nil
    end
  end


end
