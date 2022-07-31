defmodule Rocketlivery.Stack do
  use GenServer

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  # Esta função sempre é sincrona
  @impl true
  def handle_call({:push, elem}, _from, state) do
    # O retorno é uma tupla com os seguintes dados
    # o PRIMEIRO elemento é uma flag indicando se haverá uma resposta ou nao (no caso sim),
    # o SEGUNDO elemento é o dado que sera retornado
    # o TERCEIRO elemento é o estado atual (depois de manipulado)
    {:reply, [elem | state], [elem | state]}
  end

  # Esta função sempre é assincrona (não retorna nada [:noreply])
  @impl true
  def handle_cast({:push, elem}, state) do
    {:noreply, [elem | state]}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end
end
