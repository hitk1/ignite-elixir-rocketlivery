defmodule RocketliveryWeb.WelcomeController do
  use RocketliveryWeb, :controller

  def index(conn, params) do
    conn
    |> put_status(:ok)
    |> text("Olá")
  end
end
