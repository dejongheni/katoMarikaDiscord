defmodule KatoMarika.Commands.Base do
  use Alchemy.Cogs
  use Alchemy.Events
  alias Alchemy.{Client, Cache, User, Embed, Webhook}
  import Embed
  alias KatoMarika.Util.Time

  @doc """
  : Affiche la latence
  """
  Cogs.def ping do
    # message is an implicit parameter to commands
    old = message.timestamp
    {:ok, task} = Client.send_message(message.channel_id, "pong!")
    time = Time.diff(task.timestamp, old)
    Client.edit_message(task, task.content <> "\nIl y a une latence de #{time} ms")
  end

  # @doc """
  # <prefixe> : set le prefixe des commandes à *prefixe*
  # """
  # Cogs.def prefixe(prefixe) do
  #   Cogs.set_prefix(prefixe)
  #   Cogs.say "Le nouveau préfixe est "<>prefixe
  # end

  @doc """
  <phrase> : Renvois *phrase*
  """
  Cogs.def echo do
    String.split(message.content)
      |> tl
      |> Enum.join(" ")
      |> Cogs.say
  end

  @doc """
  : Affiche l'aide
  """
  Cogs.def help do
    doc = Code.get_docs(KatoMarika.Commands.Base, :docs) |> tl |> Enum.sort_by(&(elem(&1,0)))
    |> Enum.map(fn(x) -> Atom.to_string(elem(elem(x,0),0)) <>" "<> (case elem(x,4) do nil -> ""; x -> x end) end)
    |> Enum.reduce(fn(x,acc) -> acc <> "\n" <> x end)
    %Embed{}
    |> title("Documentation")
    |> description(doc)
    |> thumbnail("https://i.imgur.com/Qe4ZbwY.png")
    |> Embed.send
  end

  @doc """
  : Des informations sur moi
  """
  Cogs.def info do
    {:ok, user}=Client.get_user("@me")
    %Embed{}
    |> title("Infos")
    |> description("Je suis KatoMarika, la capitaine du vaisseau Pirate Bentenmaru !\n\n"
        <>"Retrouve moi ici : https://github.com/kornakh/katomarikadiscord")
    |> thumbnail(User.avatar_url(user))
    |> Embed.send
  end

end
