defmodule KatoMarika.Command do
  alias KatoMarika.Commands.Base

  defp actionable_command?(msg) do
    String.starts_with?(msg.content, Application.get_env(:katomarikadiscord, :prefix)) and msg.author.id != Application.get_env(:katomarikadiscord, :botID)
  end

  def handle(msg) do
    if actionable_command?(msg) do
      msg.content
      |> String.trim()
      |> String.slice(1..-1)
      |> String.split(" ", parts: 2)
      |> execute(msg)
    end
  end

  def execute(["ping"], msg) do
    Base.ping(msg)
  end

  def execute(["event", content], msg) do
    Base.event(msg, content)
  end

  def execute(["help"], msg) do
    Base.help(msg)
  end

  def execute(["info"], msg) do
    Base.info(msg)
  end

  def execute(["roll", content], msg) do
    Base.roll(msg, content)
  end

  def execute(["delete", content], msg) do
    Base.delete(msg, content)
  end

  def execute(_any, _msg) do
    :noop
  end
end
