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
  <*x*d*y*> : je lance *x* dés à *y* faces
  """
  Cogs.def roll(dices\\"1d20") do
    [nbDice, face]=String.split(String.downcase(dices), "d")
      |> Enum.map(fn(x)->String.to_integer(x)end)


    tasks=for _ <- 1..nbDice do
     Task.async(fn->:rand.uniform(face)end)
    end
    tasks_with_results = Task.yield_many(tasks, 50000000)
    tasks_with_results = Enum.map(tasks_with_results, fn {_,res} ->
      elem(res,1)
    end)
    total = Enum.reduce(tasks_with_results, fn(x, acc)-> x+acc end)

    results = Enum.join(tasks_with_results, ", ")
    s1 = if nbDice>1 do "s" else "" end
    s2 = if face>1 do "s" else "" end
    total = if nbDice>1 do "Ce qui me fait un total de **#{total}**" else "" end
    Cogs.say "J'ai lancé **#{nbDice}** dé#{s1} à **#{face}** face#{s2}\n"
      <> "J'obtiens le#{s1} résultat#{s1} suivant#{s1} : **#{results}**\n"
      <> total
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
