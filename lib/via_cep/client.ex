defmodule Rocketlivery.ViaCep.Client do
  use Tesla

  alias Tesla.Env, as: TeslaEnv
  alias Rocketlivery.Error
  alias Rocketlivery.ViaCep.Behaviour

  @behaviour Behaviour

  # Configurando a base URL que este modulo vai usar
  # plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"
  @base_url "https://viacep.com.br/ws"

  # Middleware de manipualação dos payload, tanto envio quando resposta serão encodados pra JSON
  plug Tesla.Middleware.JSON

  # É necessário informar os parametros dessa forma para que os testes funcionem corretamente
  def get_cep_info(url \\ @base_url, cep) do
    get("#{url}#{cep}/json")
    |> handle_response()
  end

  defp handle_response({:ok, %TeslaEnv{status: 400, body: _any}}) do
    {:error, Error.build(:bad_request, "Invalid CEP")}
  end

  defp handle_response({:ok, %TeslaEnv{status: 200, body: %{"erro" => "true"}}}) do
    {:error, Error.build(:bad_request, "CEP not found!")}
  end

  defp handle_response({:ok, %TeslaEnv{status: 200, body: body}}), do: {:ok, body}

  defp handle_response({:error, reason}), do: {:error, Error.build(:bad_request, reason)}
end
