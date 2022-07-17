defmodule RocketliveryWeb.FallbackController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Error
  alias RocketliveryWeb.ErrorView

  def call(conn, {:error, %Error{status: status, reason: reason}}) do
    IO.inspect(reason)

    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
