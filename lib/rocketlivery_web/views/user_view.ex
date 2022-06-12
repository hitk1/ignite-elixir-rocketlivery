defmodule RocketliveryWeb.UsersView do
  use RocketliveryWeb, :view

  alias Rocketlivery.User

  def render("user_created.json", %{user: %User{} = user}) do
    %{
      message: "User craeted successfully!",
      user: %{
        id: user.id,
        name: user.name
      }
    }
  end

  def render("show.json", %{user: %User{} = user}), do: %{user: user}
end
