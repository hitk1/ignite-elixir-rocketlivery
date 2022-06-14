defmodule RocketliveryWeb.Plug.UUIDChecker do
  import Plug.Conn

  alias Plug.Conn
  alias Ecto.UUID

  def init(options), do: options

  def call(%Conn{params: %{"id" => id}} = conn, _opts) do
    case(UUID.cast(id)) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  def call(conn, _opts), do: conn

  defp render_error(conn) do
    body =
      Jason.encode!(%{
        message: "Invalid UUID"
      })

    # as funções disponíveis dentro do controller não estarão disponíveis aqui
    # por tanto a requisição deve ser manipulada da forma a seguir

    # Primeiro manipula o cabeçalho da requisição
    # Segundo seta qual o status code da requisição
    # Terceiro, a função "halt" não deixa a requisição ser levada "à frete", ela é retornada para o cliente neste ponto
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
