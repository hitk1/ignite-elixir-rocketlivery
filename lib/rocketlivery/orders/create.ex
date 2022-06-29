defmodule Rocketlivery.Orders.Create do
  import Ecto.Query
  alias Rocketlivery.{Item, Repo, Error, Order}

  def call(params) do
    params
    |> fetch_items()
  end

  defp fetch_items(%{"items" => item_params}) do
    item_ids = Enum.map(item_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> validate_items(item_ids)
  end

  defp validate_items(items, item_ids) do
    valid_items_map = Map.new(items, fn item -> {item.id, item} end)

    item_ids
    |> Enum.map(fn id -> {id, Map.get(valid_items_map, id)} end)
    |> Enum.any?(fn {_id, content} -> is_nil(content) end)
  end
end
