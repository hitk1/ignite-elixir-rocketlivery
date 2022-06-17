defmodule RocketliveryWeb.UsersViewTest do
  use RocketliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rocketlivery.Factory

  alias RocketliveryWeb.UsersView

  test "renders user_created.json" do
    user = build(:user)

    response = render(UsersView, "user_created.json", user: user)

    assert %{
             message: "User created successfully!",
             user: %{
               id: "34998af8-9c2d-4961-a0d7-51666758cf2e",
               name: "Testing app"
             }
           } == response
  end
end
