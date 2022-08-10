defmodule Rocketlivery.Orders.ReportRunner do
  use GenServer

  require Logger
  # Client
  def start_link(_initial) do
    GenServer.start_link(__MODULE__, %{})
  end

  # Server

  @impl true
  def init(state) do
    schedule_trigger()
    {:ok, state}
  end

  @impl true
  # Esta função recebe qualquer outro tipo de mensagem vindo do sistema que não seja do tipo 'call' ou 'cast'
  def handle_info(message, state) do
    Logger.info("GenServer message received: #{message}")

    schedule_trigger()
    {:noreply, state}
  end

  # Uma forma de agendar "jobs"
  def schedule_trigger do
    Process.send_after(self(), "New message", 1000)
  end
end
