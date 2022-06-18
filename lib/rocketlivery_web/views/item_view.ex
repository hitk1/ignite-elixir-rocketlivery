defmodule RocketliveryWeb.ItemsView do
  use RocketliveryWeb, :view

  alias Rocketlivery.Item

  def render("item_created.json", %{item: %Item{} = item}) do
    %{
      message: "Item created successfully!",
      item: item
    }
  end
end
