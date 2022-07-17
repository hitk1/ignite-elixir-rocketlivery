defmodule RocketliveryWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :rocketlivery

  # checa o token no cabeçalho
  plug Guardian.Plug.VerifyHeader
  # Garante que o token esta valido pelo TTL
  plug Guardian.Plug.EnsureAuthenticated
  # Carrega os dados do subject e inject na conexão
  plug Guardian.Plug.LoadResource
end
