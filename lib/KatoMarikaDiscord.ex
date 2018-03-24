defmodule KatoMarikaDiscord do
  use Application
  alias Alchemy.Client


# id : 426055346079924234
  def start(_type, _args) do
    case Application.get_env(:katomarikadiscord, :key, :error) do
      :error -> IO.puts :stderr, IO.ANSI.red<>"no config file, copy configExemple.exs to config.exs and modify key attribute to your key"
      key ->    run = Client.start(Application.get_env(:katomarikadiscord, :key))
                Alchemy.Cogs.set_prefix(".")
                use KatoMarika.Commands.Base
                use KatoMarika.Events.EventHandler
                run
    end
  end
end
