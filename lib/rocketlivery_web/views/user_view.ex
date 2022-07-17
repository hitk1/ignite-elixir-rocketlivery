defmodule RocketliveryWeb.UsersView do
  use RocketliveryWeb, :view

  alias Rocketlivery.User

  def render("user_created.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created successfully!",
      user: %{
        id: user.id,
        name: user.name
      },
      token: token
    }
  end

  def render("show.json", %{user: %User{} = user}), do: %{user: user}

  def render("signin.json", %{token: token}) do
    %{
      token: token
    }
  end
end
