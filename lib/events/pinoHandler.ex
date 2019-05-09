defmodule KatoMarika.Events.PinoHandler do
#   use Alchemy.Events
#   alias Alchemy.{Client, Cache, User, Embed, Webhook}
# #@Ikam kicks @Xeljira in the balls.

#   def received(message) do
#     require Alchemy.Cogs
#     commander = "<@" <> Application.get_env(:katomarikadiscord, :commander) <> ">"
#     botID = "<@" <> Application.get_env(:katomarikadiscord, :botID) <> ">"
#     mpList=String.split(message.content, " ")

#     case Enum.at(mpList, 2) do
#       ^commander -> Alchemy.Cogs.say "Ne touche pas à "<>commander<>" !"
#       ^botID -> Alchemy.Cogs.say "Tu as osé me toucher "<>Enum.at(mpList, 0)<>" ?!"
#                 Client.send_message(message.channel_id,"Que le feu du Bentenmaru s'abatte sur toi !",file: Path.absname("static/bentenmaruAttack1.gif"))
#       _ -> Nil
#     end

#   end
end
