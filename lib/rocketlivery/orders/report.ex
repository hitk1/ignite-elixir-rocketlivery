defmodule Rocketlivery.Orders.Report do
  import Ecto.Query

  alias Rocketlivery.{Order, Repo, Item}

  def create(filename \\ "report.csv") do
    query = from order in Order, order_by: order.user_id

    Repo.transaction(
      fn ->
        # Repo.stream() precisa, orbrigatoriamente ser executada dentro de uma transação
        query
        |> Repo.stream(max_rows: 500)
        |> Stream.chunk_every(500)
        |> Stream.flat_map(fn chunck -> Repo.preload(chunck, :items) end)
        |> Enum.map(&parse_line/1)
      end,
      # Por default, uma transação deve acontecer em até 15 secs, se passar disso, setar a opção abaixo para eliminar essa condição
      timeout: :infinity
    )
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    total_price = calculate_total(items)

    items_string = Enum.map(items, &item_to_string/1)

    "#{user_id}, #{payment_method}, #{items_string}#{total_price} \n"
  end

  defp item_to_string(%Item{category: category, description: description, price: price}) do
    "#{category}, #{description}, #{price}, "
  end

  defp calculate_total(items) do
    Enum.reduce(items, Decimal.new(0.00), &sum_price(&1, &2))
  end

  defp sum_price(%Item{price: price}, acc), do: Decimal.add(price, acc)
end
