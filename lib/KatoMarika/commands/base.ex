defmodule KatoMarika.Commands.Base do
  alias Nostrum.Api

  alias KatoMarika.Util
  alias KatoMarika.Util.Time


  import Nostrum.Struct.Embed

  require Logger

  @doc """
  : ping et affiche la latence
  """
  def ping(msg) do
    first_timestamp = msg.timestamp
    {:ok, new_msg} = Api.create_message(msg.channel_id, "pong !")
    time = Time.diff(new_msg.timestamp, first_timestamp)
    Api.edit_message(new_msg, content: new_msg.content <> "\nIl y a une latence de #{time} ms")
  end

  @doc """
  <*x*d*y*> : je lance *x* dés à *y* faces
  """
  def roll(msg, dices\\"1d20") do
    [nbDice, face]=String.split(String.downcase(dices), "d")
      |> Enum.map(fn(x)->String.to_integer(x)end)

    {nbDice,error} = if nbDice > 10000000 do
      {1000000000,"Je n'ai pas autant de dés sur moi, je n'en ai que 1000000000 :(\n"}
    else
      {nbDice,""}
    end

    s1 = if nbDice>1 do "s" else "" end
    s2 = if face>1 do "s" else "" end
    {:ok,newMessage}=Api.create_message(msg.channel_id, "#{error}Je lance **#{nbDice}** dé#{s1} à **#{face}** face#{s2}\n *je compte les résultats*")


    task=Task.async(fn->Enum.map(1..nbDice,fn(_)->:rand.uniform(face)end)end)


    tasks_with_results = Task.yield(task, 50000000) |> elem(1)
    total = Enum.reduce(tasks_with_results, fn(x, acc)-> x+acc end)
    max_size = 1800-byte_size(Integer.to_string(total))
    results = Enum.join(tasks_with_results, ", ")
    results = if (byte_size(results)>1800) do String.slice(results,0..max_size)<>"..." else results end


    total = if nbDice>1 do "Ce qui me fait un total de **#{total}**" else "" end
    Api.edit_message(newMessage, content: "J'ai lancé **#{nbDice}** dé#{s1} à **#{face}** face#{s2}\n"
      <> "J'obtiens le#{s1} résultat#{s1} suivant#{s1} : **#{results}**\n"
      <> total)
  end

  @doc """
  <event> : je créer un evenement et supprime le message du demandeur
  """
  def event(msg, content) do
    Api.delete_message(msg)
    {:ok, newMessage} = Api.create_message(msg.channel_id,  content)#String.split(msg.content) |> tl |> Enum.join(" "))
    Util.add_reaction(newMessage, "\u2B55") #emoji rond
    Util.add_reaction(newMessage, "\u274C")
    Util.add_reaction(newMessage, "\u2753")
  end

  @doc """
  : Affiche l'aide
  """
  def help(msg) do
    {_,_,_,_,_,_,docs} = Code.fetch_docs(KatoMarika.Commands.Base)
    doc = docs
    |> Enum.map(fn(x) ->
            Atom.to_string(elem(elem(x,0),1)) <>" "<> (case elem(x,3) do %{"en"=>value}->value;:none->"" end) end)
    |> Enum.join
    embed =
      %Nostrum.Struct.Embed{}
      |> put_title("Documentation")
      |> put_description(doc)
      |> put_thumbnail("https://i.imgur.com/Qe4ZbwY.png")

    Api.create_message(msg.channel_id, embed: embed)
  end

  @doc """
  : Des informations sur moi
  """
  def info(msg) do
    {:ok, user}=Api.get_user("@me")
    embed = %Nostrum.Struct.Embed{}
    |> put_title("Infos")
    |> put_description("Je suis Kato Marika, la capitaine du vaisseau Pirate Bentenmaru !\n\n"
        <>"Retrouve moi ici : https://github.com/kornakh/katomarikadiscord")
    |> put_thumbnail(Nostrum.Struct.User.avatar_url(user))
    Api.create_message(msg.channel_id, embed: embed)
  end


end
