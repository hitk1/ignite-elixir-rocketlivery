defmodule RocketliveryWeb.FallbackController do
  alias RocketliveryWeb.ErrorView

  def call(conn, {:error, %{status: status, reason: reason}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
