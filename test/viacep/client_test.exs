defmodule Rocketlivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias Rocketlivery.ViaCep.Client

  describe "get_cep_info/1" do
    setup do
      # Fazendo isto, garantimos que o as requisições serão feitas pro servidor local
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid cep, return the cep info", %{bypass: bypass} do
      mocked_cep = "01001000"

      url = endpoint_url(bypass.port)

      # Sigil de criação de string, tudo que estiver dentro do parenteses será transformado em uma string
      body = ~s(
        {
          "cep": "01001-000",
          "logradouro": "Praça da Sé",
          "complemento": "lado ímpar",
          "bairro": "Sé",
          "localidade": "São Paulo",
          "uf": "SP",
          "ibge": "3550308",
          "gia": "1004",
          "ddd": "11",
          "siafi": "7107"
        }
      )

      Bypass.expect(
        bypass,
        "GET",
        "#{mocked_cep}/json",
        fn conn ->
          conn
          # é sempre necessário informar o content type para respostas recebidas em JSON
          |> Plug.Conn.put_resp_header("content-type", "application/json")
          |> Plug.Conn.resp(200, body)
        end
      )

      {result_action, _response} = Client.get_cep_info(url, mocked_cep)

      expected_response = {
        :ok,
        %{
          cep: "01001-000",
          logradouro: "Praça da Sé",
          complemento: "lado ímpar",
          bairro: "Sé",
          localidade: "São Paulo",
          uf: "SP",
          ibge: "3550308",
          gia: "1004",
          ddd: "11",
          siafi: "7107"
        }
      }

      # Teve que ser feito dessa forma porque o auto format esta removendo as strings do map
      assert result_action == :ok
    end

    test "when the cep is invalid, returns an error", %{bypass: bypass} do
      mocked_wrong_cep = "123"

      url = endpoint_url(bypass.port)

      Bypass.expect(
        bypass,
        "GET",
        "/#{mocked_wrong_cep}/json",
        fn conn ->
          conn
          |> Plug.Conn.resp(400, "")
        end
      )

      response = Client.get_cep_info(url, mocked_wrong_cep)

      expected_response =
        {:error, %Rocketlivery.Error{reason: "Invalid CEP", status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
