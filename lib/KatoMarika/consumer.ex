defmodule KatoMarika.Consumer do
  use Nostrum.Consumer

  alias KatoMarika.Command

  def start_link do
    Consumer.start_link(__MODULE__, max_restarts: 0)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    IO.inspect(msg)
    Command.handle(msg)
  end

  def handle_event(_event) do
    :noop
  end
end
