defmodule KatoMarikaDiscord do
  use Application
  alias Alchemy.Client


# id : 426055346079924234
  def start(_type, _args) do

    run = Client.start(Application.get_env(:katomarikadiscord, :key))
    Alchemy.Cogs.set_prefix(".")
    use KatoMarika.Commands.Base
    use KatoMarika.Events.EventHandler
    run
  end
end
